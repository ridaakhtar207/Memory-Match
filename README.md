# Karachi Mart 🛒

A grocery delivery app for **Karachi, Pakistan** — a mobile storefront (Expo / React Native)
backed by a Next.js + SQLite API. Browse fresh fruits, vegetables, dairy, meat and daily
essentials, build a cart, and place **Cash-on-Delivery** (or JazzCash / Easypaisa / Bank
Transfer) orders delivered to your area anywhere in Karachi.

---

## What's inside

```
karachi-grocery/
├── backend/     Next.js 14 API + SQLite (built-in node:sqlite, zero native deps)
└── mobile/      Expo (React Native) storefront
```

### Features

**Mobile app**
- Home with hero banner, live search, featured products and a category grid
- Category browsing and product detail (English + Urdu names)
- Cart with quantity steppers, free-delivery progress, and AsyncStorage persistence
- Checkout with Karachi area picker (per-area delivery charge + ETA), payment method and notes
- Live order summary (subtotal, delivery, total) with free delivery over Rs. 3,000
- Order confirmation and a live order-tracking timeline (polls for status updates)
- "My Orders" history

**Backend API**
- 12 categories, 87 products, 30 Karachi delivery areas (DHA, Clifton, Gulshan, Korangi…)
- Prices in PKR; server-side pricing (never trusts client prices)
- Order creation, retrieval and validation; area-based delivery charges; free-delivery threshold

---

## Prerequisites

- **Node.js 20+** (this project was built and tested on Node 26). The backend uses Node's
  built-in `node:sqlite`, so there are **no native modules** to compile.

> If `npm` is blocked by PowerShell's execution policy, use `npm.cmd` instead of `npm`,
> or run commands inside `cmd.exe`.

---

## 1. Run the backend (API)

```bash
cd backend
npm install          # or: npm.cmd install
npm run dev          # starts http://localhost:3000
```

The SQLite database is created and seeded automatically on first run at
`backend/data/grocery.db`. To reset the data, delete that file and restart.

Quick test: open <http://localhost:3000/api/products?featured=1>

---

## 2. Run the mobile app

```bash
cd mobile
npm install          # or: npm.cmd install
npx expo start       # then press: a (Android), i (iOS), or w (web)
```

### Important: point the app at your backend

Edit `mobile/src/config.ts` and set `API_URL` to match how you're testing:

| Where it runs                | `API_URL` value                    |
| ---------------------------- | ---------------------------------- |
| iOS simulator / web          | `http://localhost:3000` (default)  |
| Android emulator             | `http://10.0.2.2:3000`             |
| Real phone (same Wi-Fi)      | `http://<YOUR_PC_LAN_IP>:3000`     |

To find your PC's LAN IP on Windows: `ipconfig` → look for the IPv4 address
(e.g. `192.168.1.10`). Make sure your phone and PC are on the **same Wi-Fi** and that
Windows Firewall allows Node.js inbound on port 3000.

---

## API reference

| Method | Endpoint                    | Description                                  |
| ------ | --------------------------- | -------------------------------------------- |
| GET    | `/api/categories`           | All categories with product counts           |
| GET    | `/api/products`             | List products (`?category=slug`, `?search=`, `?featured=1`) |
| GET    | `/api/products/:id`         | Single product                               |
| GET    | `/api/delivery-areas`       | Karachi delivery areas + free-delivery threshold |
| POST   | `/api/orders`               | Create an order (COD / JazzCash / Easypaisa / Bank) |
| GET    | `/api/orders/:orderNumber`  | Fetch an order for tracking                  |

### Example order payload

```json
POST /api/orders
{
  "customer_name": "Ahmed Raza",
  "phone": "0300-1234567",
  "address": "House 123, Street 4",
  "area_id": 3,
  "payment_method": "COD",
  "items": [
    { "product_id": 1, "quantity": 2 },
    { "product_id": 37, "quantity": 1 }
  ]
}
```

---

## Notes / roadmap ideas

- Product imagery uses emoji so the app runs fully offline; swap in real photos by
  adding image URLs to the `products` table.
- Order statuses are seeded/managed server-side; a small admin panel to move orders
  through `placed → confirmed → packing → out_for_delivery → delivered` is a natural
  next step.
- Add OTP-based login (via a local SMS gateway) and repeat-customer addresses next.
