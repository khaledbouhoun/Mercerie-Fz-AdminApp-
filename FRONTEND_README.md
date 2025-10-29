# E-Commerce Mobile App - Frontend & Backend

This project consists of a Flutter mobile application with a PHP backend API for managing products and categories.

## 🚀 Features

### Flutter Frontend
- **Modern UI/UX**: Clean, responsive design with Material Design components
- **Products Page**: Grid layout with search, filtering, and product details
- **Categories Page**: Browse categories with product counts
- **State Management**: GetX for reactive state management
- **Error Handling**: Comprehensive error states and loading indicators
- **Pull-to-Refresh**: Refresh data with pull-to-refresh functionality
- **Product Details**: Modal bottom sheet with product information
- **Add to Cart**: Basic cart functionality (placeholder)

### PHP Backend
- **RESTful API**: Clean API endpoints for products and categories
- **Database Integration**: MySQL database support with fallback to sample data
- **CORS Support**: Cross-origin resource sharing enabled
- **Error Handling**: Proper HTTP status codes and error messages
- **Search & Filter**: Product search and category filtering
- **Sample Data**: Fallback data when database is unavailable

## 📁 Project Structure

```
admin_ecommerce_app/
├── lib/
│   ├── controller/
│   │   ├── product/
│   │   │   └── product_controller.dart
│   │   └── frontend/
│   │       └── category_frontend_controller.dart
│   ├── data/
│   │   ├── model/
│   │   │   ├── product_model.dart
│   │   │   └── category_model.dart
│   │   └── remote/
│   │       └── api_service.dart
│   ├── view/
│   │   └── frontend/
│   │       ├── main_frontend_page.dart
│   │       ├── products_page.dart
│   │       └── categories_page.dart
│   └── widget/
│       └── frontend/
│           ├── product_card.dart
│           ├── category_card.dart
│           └── search_bar.dart

mercerie/
└── api/
    ├── products.php
    └── categories.php
```

## 🛠️ Setup Instructions

### Prerequisites
- Flutter SDK (3.7.2 or higher)
- PHP 7.4 or higher
- MySQL/MariaDB database
- Web server (Apache/Nginx) or PHP built-in server
- Android Studio / VS Code

### Flutter Frontend Setup

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd admin_ecommerce_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Update API base URL**
   Open `lib/data/remote/api_service.dart` and update the `baseUrl`:
   ```dart
   static const String baseUrl = 'http://YOUR_IP_ADDRESS:PORT/mercerie/api';
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

### PHP Backend Setup

1. **Set up web server**
   - Copy the `mercerie` folder to your web server directory
   - Or use PHP built-in server:
     ```bash
     cd mercerie
     php -S 0.0.0.0:8012
     ```

2. **Configure database**
   - Create a MySQL database named `mercerie`
   - Update database credentials in `api/products.php` and `api/categories.php`:
     ```php
     $host = 'localhost';
     $dbname = 'mercerie';
     $username = 'your_username';
     $password = 'your_password';
     ```

3. **Database tables** (if using existing database)
   The API will work with your existing `items` and `categories` tables.
   If you don't have a database, the API will fall back to sample data.

4. **Test the API**
   ```bash
   curl http://localhost:8012/mercerie/api/products.php
   curl http://localhost:8012/mercerie/api/categories.php
   ```

## 📱 Usage

### Navigation
- **Main Page**: Shows featured products and categories
- **Products Page**: Browse all products with search and filtering
- **Categories Page**: Browse categories and navigate to category-specific products

### Features
- **Search**: Tap the search icon to search for products
- **Filter**: Use the filter icon to filter products by category
- **Product Details**: Tap on a product card to view details
- **Add to Cart**: Tap the cart icon on product cards to add items

## 🔧 Configuration

### Flutter Configuration
- **API Base URL**: Update in `lib/data/remote/api_service.dart`
- **Theme Colors**: Modify in `lib/core/constant/color.dart`
- **Dependencies**: Check `pubspec.yaml` for required packages

### PHP Configuration
- **Database**: Update connection details in API files
- **CORS**: Modify headers in API files if needed
- **Image URLs**: Update image path construction in database queries

## 🗄️ Database Schema

### Items Table
```sql
CREATE TABLE items (
    items_id INT PRIMARY KEY AUTO_INCREMENT,
    items_name_fr VARCHAR(255),
    items_price DECIMAL(10,2),
    items_desc_fr TEXT,
    items_image VARCHAR(255),
    items_cat INT,
    items_active TINYINT DEFAULT 1,
    items_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Categories Table
```sql
CREATE TABLE categories (
    categories_id INT PRIMARY KEY AUTO_INCREMENT,
    categories_name VARCHAR(255),
    categories_image VARCHAR(255)
);
```

## 🚀 Deployment

### Flutter App
1. **Build for production**
   ```bash
   flutter build apk --release
   flutter build ios --release
   ```

2. **Deploy to stores**
   - Follow Flutter's official deployment guides
   - Update API URLs for production

### PHP Backend
1. **Upload to web server**
   - Upload `mercerie/api/` folder to your web server
   - Ensure proper file permissions

2. **Configure production database**
   - Update database credentials
   - Set up proper security measures

## 🔒 Security Considerations

- **API Security**: Implement authentication for production use
- **Database Security**: Use prepared statements (already implemented)
- **CORS**: Configure CORS headers appropriately for production
- **Input Validation**: Add input validation for search parameters

## 🐛 Troubleshooting

### Common Issues

1. **API Connection Failed**
   - Check if PHP server is running
   - Verify API base URL in Flutter app
   - Check network connectivity

2. **Database Connection Failed**
   - Verify database credentials
   - Check if database server is running
   - API will fall back to sample data

3. **Images Not Loading**
   - Check image URLs in database
   - Verify image file permissions
   - Update image path construction in API

### Debug Mode
- Enable Flutter debug mode for detailed logs
- Check PHP error logs for backend issues
- Use browser developer tools to test API endpoints

## 📄 License

This project is for educational purposes. Feel free to modify and use as needed.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📞 Support

For issues and questions:
- Check the troubleshooting section
- Review error logs
- Test API endpoints independently
- Verify network connectivity

---

**Note**: This is a demonstration project. For production use, implement proper authentication, security measures, and error handling. 