# 🎯 GUÍA RÁPIDA DE CONFIGURACIÓN - 15 MINUTOS

## 🚀 Instalación en 3 Pasos

### Paso 1: Preparación (2 minutos)
```bash
# Descargar el proyecto
git clone https://github.com/tu-usuario/ecommerce-platform.git
cd ecommerce-platform

# Ejecutar instalación automática
bash install.sh
```

### Paso 2: Configurar APIs (10 minutos)

#### 🔑 OpenAI (Esencial)
1. Ve a https://platform.openai.com/api-keys
2. Crea cuenta y API key
3. Abre `backend/.env` y añade:
```
OPENAI_API_KEY=sk-tu-api-key-aqui
```

#### 🗄️ Supabase (Base de datos)
1. Ve a https://supabase.com y crea proyecto
2. Settings → API → Copia URL y Service Role Key
3. En `backend/.env`:
```
SUPABASE_URL=https://tu-proyecto.supabase.co
SUPABASE_KEY=tu_service_role_key
```

#### 💳 Stripe (Pagos)
1. Ve a https://dashboard.stripe.com/apikeys
2. Crea cuenta y obtén Test Secret Key
3. En `backend/.env`:
```
STRIPE_SECRET_KEY=sk_test_tu_key
STRIPE_PUBLISHABLE_KEY=pk_test_tu_key
```

### Paso 3: Ejecutar (3 minutos)

#### Desarrollo:
```bash
./start-dev.sh
```

#### Producción:
```bash
./start-production.sh
```

---

## 🌐 URLs del Sistema

- **Frontend**: http://localhost:3000
- **Backend API**: http://localhost:5000
- **Health Check**: http://localhost:5000/health

---

## ⚡ Comandos Útiles

```bash
# Iniciar desarrollo completo
./start-dev.sh

# Solo backend
cd backend && npm run dev

# Solo frontend  
cd frontend && npm run dev

# Build para producción
./start-production.sh

# Setup base de datos
cd backend && npm run setup-db

# Test APIs
curl http://localhost:5000/health
```

---

## 🔧 Configuración Rápida de Variables

### backend/.env (Mínimo necesario):
```env
NODE_ENV=development
PORT=5000
JWT_SECRET=tu_secret_super_seguro_minimo_32_caracteres

# Esenciales
OPENAI_API_KEY=sk-tu-openai-key
SUPABASE_URL=https://tu-proyecto.supabase.co
SUPABASE_KEY=tu-service-role-key
STRIPE_SECRET_KEY=sk_test_tu-stripe-key

# URLs
FRONTEND_URL=http://localhost:3000
```

### frontend/.env.local (Opcional):
```env
VITE_API_URL=http://localhost:5000
VITE_DEBUG_MODE=true
```

---

## ✅ Verificación de Funcionamiento

### 1. Verificar Backend
```bash
curl http://localhost:5000/health
```
**Debe responder**: `{"status":"OK",...}`

### 2. Verificar Frontend
Visita http://localhost:3000
**Debe mostrar**: La página principal de la tienda

### 3. Verificar Base de Datos
- El backend debe conectar sin errores
- No debe aparecer mensaje "Cannot connect to database"

### 4. Test de IA
- Ve a "Análisis de Productos"
- Añade un producto para analizar
- Debe funcionar sin errores de API

---

## 🚨 Solución de Problemas Rápidos

### Error: "Cannot connect to database"
- Verifica credenciales de Supabase
- Confirma que el proyecto esté activo
- Ejecuta: `cd backend && npm run setup-db`

### Error: "OpenAI API rate limit"
- Verifica tu API key
- En desarrollo está limitado, es normal
- Para producción considera hacer upgrade

### Error: "Frontend no conecta"
- Confirma que backend esté ejecutándose en puerto 5000
- Verifica VITE_API_URL en frontend/.env.local

### Error: "Port 3000 already in use"
```bash
# Matar procesos en puertos específicos
lsof -ti:3000 | xargs kill -9
lsof -ti:5000 | xargs kill -9
```

---

## 🎯 Configuración para Producción

### Deploy Frontend (Vercel):
```bash
cd frontend
npm run build
vercel --prod
```

### Deploy Backend (Railway):
```bash
cd backend
railway login
railway init
railway up
```

### Variables de Producción:
Cambiar en backend/.env:
```env
NODE_ENV=production
FRONTEND_URL=https://tu-frontend.vercel.app
PAYPAL_MODE=live
```

---

## 💰 Empezar a Ganar Dinero

### 1. Configurar Métodos de Pagos
- Conecta cuenta bancaria a Stripe
- Añade tarjeta a PayPal
- Testa con tarjetas de prueba primero

### 2. Añadir Productos
- Ve a "Análisis de Productos"
- Pega URLs de productos (Amazon, AliExpress)
- Publica productos con score > 60

### 3. Configurar Marketing
- Ve a "Marketing Automatizado"
- Crea campañas de email
- Programa publicaciones en redes sociales

### 4. Monitorear
- Dashboard: http://localhost:3000/dashboard
- Analytics: http://localhost:3000/analytics
- Revisa ganancias en configuración

---

## 🆘 Soporte

### Documentación Completa:
- `docs/installation.md` - Guía detallada
- `docs/api-setup.md` - Configuración de APIs
- `docs/payment-setup.md` - Configuración de pagos

### Logs para Debug:
- Backend: Consola donde ejecutes el backend
- Frontend: Consola del navegador (F12)

### Test Rápido:
```bash
# Test completo del sistema
curl -X POST http://localhost:5000/api/products/analyze \
  -H "Content-Type: application/json" \
  -d '{"title": "iPhone 15", "price": 899}'
```

---

¡Tu plataforma está lista para generar ingresos automáticos! 🚀💰

**Recuerda**: Este es un sistema de dropshipping automatizado. Cada venta genera ganancias automáticas y el sistema maneja todo el proceso desde la compra hasta la entrega.