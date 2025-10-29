# E-Commerce Admin Dashboard

A comprehensive Flutter dashboard for the e-commerce admin panel with modern UI, interactive charts, and real-time data visualization.

## Features

### 📊 Key Metrics
- **Total Sales**: Overall revenue from all completed orders
- **Total Orders**: Number of completed orders
- **Average Order Value**: Average amount per order

### 📈 Interactive Charts
- **Sales by Payment Method**: Pie chart showing breakdown of sales by payment method (Cash vs Delivery)
- **Sales Over Time**: Line chart displaying sales trends with selectable time periods

### 🎨 Modern UI
- Responsive design that works on mobile, tablet, and desktop
- Clean, professional color scheme
- Smooth animations and transitions
- Loading states and error handling

### ⚡ Real-time Data
- Pull-to-refresh functionality
- Automatic data loading
- Error handling with user-friendly messages

## Technical Implementation

### Flutter Components

#### 1. Data Models (`lib/data/model/dashboard_model.dart`)
```dart
- DashboardSalesData: Overall sales statistics
- PaymentMethodData: Payment method breakdown
- SalesOverTimeData: Time series sales data
- DashboardResponse: API response wrapper
```

#### 2. Data Service (`lib/data/remote/dashboard_data.dart`)
```dart
- getDashboardSales(): Fetch overall sales data
- getSalesByPaymentMethod(): Fetch payment method breakdown
- getSalesOverTime(): Fetch time series data with date filtering
```

#### 3. Controller (`lib/controller/dashboard/dashboard_controller.dart`)
```dart
- State management using GetX
- Data loading and error handling
- Date range calculations
- Currency and number formatting
```

#### 4. UI (`lib/view/stats/stats.dart`)
```dart
- Responsive layout with LayoutBuilder
- Interactive charts using fl_chart
- Modern card-based design
- Loading and error states
```

### PHP Backend

#### 1. Database Schema
The dashboard works with your existing database tables:
```sql
-- Orders table (Cash orders)
CREATE TABLE orders (
    orders_id INT PRIMARY KEY AUTO_INCREMENT,
    orders_usersid INT,
    shop TINYINT(1), -- 2 = cash orders
    orders_totalprice DECIMAL(10,2),
    orders_status INT, -- 3 = completed
    orders_employe INT,
    orders_datetime TIMESTAMP,
    -- other fields...
);

-- Yallidine orders table (Delivery orders)
CREATE TABLE orders_yallidine (
    y_id INT PRIMARY KEY AUTO_INCREMENT,
    y_userid INT,
    y_totalprice DECIMAL(10,0),
    y_statue INT, -- 3 = completed
    y_datetime TIMESTAMP,
    -- other fields...
);
```

**Key Points:**
- **Cash Orders**: `orders` table where `shop = 2` and `orders_status = 3`
- **Delivery Orders**: `orders_yallidine` table where `y_statue = 3`
- **Completed Orders**: Status value of `3` indicates completed orders

#### 2. API Endpoints

**Dashboard Sales Data** (`/api/dashboard_sales.php`)
```json
{
  "success": true,
  "message": "Dashboard sales data retrieved successfully",
  "sales_data": {
    "total_sales": 12500.50,
    "total_orders": 150,
    "average_order_value": 83.34
  }
}
```

**Payment Method Breakdown** (`/api/sales_by_payment_method.php`)
```json
{
  "success": true,
  "message": "Payment method data retrieved successfully",
  "payment_methods": [
    {
      "method": "Cash",
      "amount": 7500.25,
      "percentage": 60.0
    },
    {
      "method": "Delivery",
      "amount": 5000.25,
      "percentage": 40.0
    }
  ]
}
```

**Sales Over Time** (`/api/sales_over_time.php`)
```json
{
  "success": true,
  "message": "Sales over time data retrieved successfully",
  "sales_over_time": [
    {
      "date": "2024-01-01",
      "amount": 250.00
    },
    {
      "date": "2024-01-02", 
      "amount": 300.50
    }
  ],
  "date_range": {
    "start_date": "2024-01-01",
    "end_date": "2024-01-31"
  }
}
```

## Setup Instructions

### 1. Flutter Setup
1. Ensure you have Flutter installed and configured
2. Add the `fl_chart` dependency to `pubspec.yaml`:
   ```yaml
   dependencies:
     fl_chart: ^0.69.0
   ```
3. Run `flutter pub get` to install dependencies

### 2. PHP Backend Setup
1. Place the PHP files in your web server directory:
   - `mercerie/adminapp/api/dashboard_sales.php`
   - `mercerie/adminapp/api/sales_by_payment_method.php`
   - `mercerie/adminapp/api/sales_over_time.php`

2. Ensure your database has the required tables (`cash_orders` and `delivery_orders`)

3. Update the database connection in `mercerie/connect.php` if needed

### 3. Configuration
1. Update the server URL in `lib/linkapi.dart` to match your PHP backend
2. Ensure the API endpoints are accessible from your Flutter app

## Usage

### Accessing the Dashboard
The dashboard is accessible through the `Stats` widget in your Flutter app. It automatically loads data when initialized.

### Time Period Selection
Users can select different time periods for the sales over time chart:
- Today
- Last 7 Days
- Last 30 Days (default)
- Last 90 Days

### Data Refresh
- Pull down to refresh all data
- Use the refresh button in the app bar
- Data automatically loads when the page is opened

## Customization

### Colors and Styling
The dashboard uses the app's color scheme defined in `lib/core/constant/color.dart`. You can customize:
- Primary colors
- Background colors
- Chart colors
- Card styling

### Chart Customization
The charts can be customized by modifying:
- Chart colors in `_buildPieChartSections()`
- Line chart styling in `_buildSalesOverTimeChart()`
- Chart dimensions and spacing

### Data Sources
To add new data sources:
1. Create new API endpoints
2. Add corresponding methods in `DashboardData`
3. Update the controller to handle new data
4. Add UI components to display the data

## Error Handling

The dashboard includes comprehensive error handling:
- Network connectivity issues
- API errors
- Database errors
- Invalid data responses

Error messages are displayed in a user-friendly format with retry options.

## Performance Considerations

- Data is cached in the controller to avoid unnecessary API calls
- Charts are optimized for smooth rendering
- Images and assets are properly sized
- API responses are validated before processing

## Security

- All database queries use prepared statements
- Input validation on date parameters
- Error messages don't expose sensitive information
- CORS headers are properly configured

## Browser Compatibility

The dashboard is designed to work on:
- Mobile devices (iOS/Android)
- Tablets
- Desktop browsers
- Web applications

## Future Enhancements

Potential improvements:
- Real-time data updates using WebSockets
- Export functionality (PDF/Excel)
- More detailed analytics
- Custom date range picker
- Additional chart types
- Data filtering options 