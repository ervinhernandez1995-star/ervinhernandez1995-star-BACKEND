#!/bin/bash

# 🚀 Script de Instalación Automática - Plataforma E-commerce Automatizada
# Versión 1.0
# 
# Este script automatiza la instalación completa del sistema
# Asegúrate de tener Node.js 16+ instalado antes de ejecutar

set -e  # Exit on any error

echo "🚀 Iniciando instalación de la Plataforma E-commerce Automatizada"
echo "============================================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if Node.js is installed
check_nodejs() {
    print_status "Verificando Node.js..."
    if command -v node &> /dev/null; then
        NODE_VERSION=$(node --version)
        print_success "Node.js encontrado: $NODE_VERSION"
        
        # Check if version is 16 or higher
        MAJOR_VERSION=$(echo $NODE_VERSION | cut -d'v' -f2 | cut -d'.' -f1)
        if [ "$MAJOR_VERSION" -ge 16 ]; then
            print_success "Versión de Node.js compatible"
        else
            print_error "Node.js versión 16+ requerida. Versión actual: $NODE_VERSION"
            exit 1
        fi
    else
        print_error "Node.js no está instalado. Por favor instala Node.js 16+ desde https://nodejs.org"
        exit 1
    fi
}

# Check if Git is installed
check_git() {
    print_status "Verificando Git..."
    if command -v git &> /dev/null; then
        print_success "Git encontrado"
    else
        print_warning "Git no está instalado. Algunas funcionalidades pueden no estar disponibles."
    fi
}

# Install dependencies for frontend
install_frontend() {
    print_status "Instalando dependencias del frontend..."
    cd frontend
    
    if [ ! -f "package.json" ]; then
        print_error "Frontend package.json no encontrado"
        exit 1
    fi
    
    npm install
    print_success "Frontend dependencias instaladas"
    
    # Create .env.local if it doesn't exist
    if [ ! -f ".env.local" ]; then
        print_status "Creando .env.local para frontend..."
        cat > .env.local << EOF
# Backend API URL
VITE_API_URL=http://localhost:5000

# Google Analytics (opcional)
VITE_GA_TRACKING_ID=

# Configuración de modo desarrollo
NODE_ENV=development
EOF
        print_success "Archivo .env.local creado"
    fi
    
    cd ..
}

# Install dependencies for backend
install_backend() {
    print_status "Instalando dependencias del backend..."
    cd backend
    
    if [ ! -f "package.json" ]; then
        print_error "Backend package.json no encontrado"
        exit 1
    fi
    
    npm install
    print_success "Backend dependencias instaladas"
    
    # Create .env if it doesn't exist
    if [ ! -f ".env" ]; then
        print_status "Creando archivo .env para backend..."
        cp .env.example .env
        print_warning "IMPORTANTE: Necesitas completar las credenciales en backend/.env"
        print_warning "Revisa el archivo docs/installation.md para instrucciones detalladas"
    fi
    
    cd ..
}

# Setup database schema
setup_database() {
    print_status "Configurando esquema de base de datos..."
    
    # Check if SUPABASE_URL and SUPABASE_KEY are set
    if grep -q "SUPABASE_URL=https://" backend/.env && grep -q "SUPABASE_KEY=" backend/.env; then
        print_status "Ejecutando setup de base de datos..."
        cd backend
        npm run setup-db
        cd ..
        print_success "Base de datos configurada"
    else
        print_warning "Credenciales de Supabase no configuradas"
        print_warning "Configura SUPABASE_URL y SUPABASE_KEY en backend/.env antes de continuar"
    fi
}

# Create startup scripts
create_scripts() {
    print_status "Creando scripts de inicio..."
    
    # Development script
    cat > start-dev.sh << 'EOF'
#!/bin/bash

echo "🚀 Iniciando desarrollo..."

# Function to handle cleanup
cleanup() {
    echo "🛑 Cerrando procesos..."
    kill $BACKEND_PID $FRONTEND_PID 2>/dev/null
    exit
}

trap cleanup SIGINT SIGTERM

# Start backend
echo "📦 Iniciando backend..."
cd backend
npm run dev &
BACKEND_PID=$!
cd ..

# Wait a moment for backend to start
sleep 3

# Start frontend
echo "🌐 Iniciando frontend..."
cd frontend
npm run dev &
FRONTEND_PID=$!
cd ..

echo "✅ Desarrollo iniciado!"
echo "Frontend: http://localhost:3000"
echo "Backend:  http://localhost:5000"
echo "API Docs: http://localhost:5000/health"
echo ""
echo "Presiona Ctrl+C para detener"

# Wait for both processes
wait
EOF

    # Production script
    cat > start-production.sh << 'EOF'
#!/bin/bash

echo "🚀 Iniciando en modo producción..."

# Build frontend
echo "📦 Construyendo frontend..."
cd frontend
npm run build
cd ..

# Start backend
echo "🌐 Iniciando backend..."
cd backend
npm start
EOF

    # Make scripts executable
    chmod +x start-dev.sh
    chmod +x start-production.sh
    
    print_success "Scripts de inicio creados"
    print_status "  - start-dev.sh: Para desarrollo"
    print_status "  - start-production.sh: Para producción"
}

# Create documentation shortcuts
create_docs() {
    print_status "Creando accesos directos a documentación..."
    
    cat > docs-setup.md << 'EOF'
# 📚 Documentación de Configuración

## Enlaces Rápidos
- [Guía Completa de Instalación](installation.md)
- [Configuración de APIs](api-setup.md)
- [Configuración de Pagos](payment-setup.md)

## Siguiente Paso: Configurar APIs

Antes de ejecutar el sistema, necesitas configurar:

1. **OpenAI API** (Esencial)
   - Ve a: https://platform.openai.com/api-keys
   - Crea una nueva API key
   - Añádela a backend/.env como OPENAI_API_KEY

2. **Supabase** (Base de datos)
   - Ve a: https://supabase.com
   - Crea un proyecto
   - Copia URL y Service Role Key a backend/.env

3. **Stripe** (Pagos)
   - Ve a: https://dashboard.stripe.com/apikeys
   - Copia Test Secret Key a backend/.env

## Ejecutar el Sistema

### Desarrollo:
```bash
./start-dev.sh
```

### Producción:
```bash
./start-production.sh
```

EOF
    
    print_success "Documentación creada"
}

# Main installation process
main() {
    echo ""
    print_status "Iniciando instalación automatizada..."
    echo ""
    
    # Pre-flight checks
    check_nodejs
    check_git
    
    # Install dependencies
    install_frontend
    install_backend
    
    # Setup database
    setup_database
    
    # Create scripts and docs
    create_scripts
    create_docs
    
    echo ""
    echo "============================================================="
    print_success "✅ Instalación básica completada!"
    echo ""
    echo "📋 Próximos pasos:"
    echo "  1. Configurar APIs en backend/.env"
    echo "  2. Revisar docs/installation.md para detalles completos"
    echo "  3. Ejecutar './start-dev.sh' para iniciar desarrollo"
    echo ""
    print_warning "⚠️  IMPORTANTE: Completa las credenciales en backend/.env"
    print_warning "   Revisa docs/installation.md antes de continuar"
    echo ""
}

# Run main installation
main "$@"