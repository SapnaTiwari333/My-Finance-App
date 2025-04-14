# **MyFinance App**
**MyFinance** is a **full-stack personal finance management app** built using:
- **Flutter** for the frontend  
- **Firebase** for authentication and cloud storage  
- **SQLite** for local storage (categories & transactions)  
- **Provider** for state management in Flutter  
- **Shared Preferences** for local data caching and persisting user preferences  

---

## **Technology Stack**
| Component         | Technology                |
|------------------|---------------------------|
| Frontend         | Flutter                   |
| Authentication   | Firebase Authentication   |
| Cloud Database   | Firebase Firestore        |
| Local Database   | SQLite (Transactions & Categories) |
| State Management | Provider                  |
| Notifications    | Flutter Local Notifications |
| API Testing      | Firebase Emulator Suite   |
| Version Control  | Git and GitHub            |

---

## **Features**

### **1. Dashboard with Financial Summary**
- **Total Income**
- **Total Expenses**
- **Net Balance**
- **Pie chart** to visualize spending categories
- **Horizontal scrollable row** with:
  - `Total Transactions`
  - `Total Categories`
  - `Upcoming Payments`

---

### **2. Transactions Management**
- **Add**, **Edit**, and **Delete** transactions
- Select the transaction type:
  - `Income`
  - `Expense`
- Assign a **category** to each transaction
- Set a **date** for each transaction

#### **SQLite CRUD operations:**
- **CREATE** → Add new transactions  
- **READ** → Fetch all transactions  
- **UPDATE** → Modify existing transactions  
- **DELETE** → Remove transactions  

---

### **3. Categories Management**
- **Add**, **Edit**, and **Delete** categories
- Define whether a category belongs to:
  - `Income`
  - `Expense`
- Add a **description**

**Categories are saved in a separate SQLite database:**  
- `categoriesDb.db`

---

### **4. Notifications**
- Receive **notifications** for **upcoming payments**
- Local notification integration with Flutter
- Background service to trigger reminders based on the payment due date

---

### **5. User Authentication**
- **Sign up** with email and password  
- **Sign in** with existing account  
- **Password reset** functionality  
- **User profile** management  
- Secure authentication using **Firebase Auth**

---

## **Database Structure**

### **Local Transaction Database:** `transactionDb.db`

**Table:** `transactions`
- `s_no` → **Transaction ID** (Primary Key, auto-increment)  
- `title` → **Transaction title**  
- `amount` → **Transaction amount**  
- `transaction_type` → **Income or Expense**  
- `category` → **Associated category**  
- `date` → **Date of the transaction**  

---

### **Local Category Database:** `categoriesDb.db`

**Table:** `categories`
- `s_no` → **Category ID** (Primary Key, auto-increment)  
- `name` → **Category name**  
- `category_type` → **Income or Expense**  
- `description` → **Description of the category**

---

## **Setup Instructions**

### **1. Firebase Setup**
1. Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
2. Register your Android and iOS apps in the Firebase project
3. Download and add configuration files:
   - `google-services.json` (Android)
   - `GoogleService-Info.plist` (iOS)
4. Enable Authentication methods (Email/Password)
5. Set up Firestore Database

---

### **2. Flutter Project Configuration**

#### 1. Add Firebase packages to `pubspec.yaml`:
```yaml
dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^2.15.1
  firebase_auth: ^4.9.0
  cloud_firestore: ^4.9.1
  provider: ^6.1.1
  shared_preferences: ^2.2.2
  sqflite: ^2.3.2
  flutter_local_notifications: ^17.0.0
