https://github.com/user-attachments/assets/3c5d19d8-5b93-4bcc-811a-887bae3fa3fc

# Crypto 🪙

Crypto is a SwiftUI application that provides real-time cryptocurrency data fetched from the CoinGecko API. The app is architected using the MVVM design pattern, employs Core Data for local storage, and leverages Combine for reactive programming.

## 📱 Features

- **Live Cryptocurrency Prices**: Real-time price updates from CoinGecko API.
- **Favorites Management**: Mark cryptocurrencies as favorites for quick access.
- **Historical Data & Charts**: View historical trends of selected cryptocurrencies.
- **Offline Portfolio Support**: Core Data integration allows offline access to the portfolio section only.

## 🛠 Technologies & Frameworks

- **SwiftUI**: Modern, declarative UI framework for building iOS apps.
- **MVVM Architecture**: Clean separation of concerns with Model-View-ViewModel.
- **Core Data**: Persistent storage for offline portfolio support.
- **Combine**: Apple’s reactive framework for handling asynchronous events.
- **CoinGecko API**: Fetches live cryptocurrency data and historical trends.

## 🏗️ Project Structure

The project follows the MVVM architecture, with a structured organization as follows:

- `Model`: Defines the data structure for cryptocurrency information.
- `ViewModel`: Manages data handling and transforms it for the view.
- `View`: SwiftUI views that update based on data changes.
- `Services`: API layer for CoinGecko integration.
- `CoreData`: Persistence layer for offline data storage of the portfolio.


## 🗄️ Core Data

Core Data is used to persist data locally for the portfolio section, ensuring users have access to their portfolio information even when offline.

## 🌐 API Integration

The app uses the [CoinGecko API](https://www.coingecko.com/en/api) for cryptocurrency data. Make sure to review the API documentation for rate limits and usage policies.

- **Endpoint**: `/coins/markets` for market data
- **Parameters**: `vs_currency`, `ids`, and other optional filters

## 🧩 Dependencies

- **CoinGecko API**: Provides cryptocurrency market data.

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👥 Author

**Abhishek Raj Mohan Verma**
