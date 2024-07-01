# Utility Billing App

This project is a web application designed to calculate and manage utility shares for different consumers. The application provides features to input meter readings and rates, calculate utility bills based on these data, and generate reports.

## Table of Contents

- [Project Objective](#project-objective)
- [Technologies Used](#technologies-used)
- [Installation](#installation)
- [Usage](#usage)
- [License](#license)

## Project Objective

The goal of this project is to create a web application that automates utility calculations, provides clear breakdowns by flat/part of house, and gives an overview of the development of consumption and costs over time.

## Technologies Used

- **Backend:** Node.js, Express.js
- **Database:** PostgreSQL, Prisma ORM
- **Frontend:** React

## Installation

### Prerequisites

- Node.js (v14 or higher)
- PostgreSQL (v12 or higher)

### Steps

1. **Clone the repository:**
   ```
   git clone https://github.com/helenasegedin/utility-billing-app.git
   cd utility-billing-app
   ```

2. **Install dependencies:**
   ```
   npm install
   ```

3. **Set up the database:**

   Ensure PostgreSQL is installed and running. Create a new database:
   ```
   createdb utility_billing
   ```

4. **Configure environment variables:**

   Create a `.env` file in the project root and add your database URL:
   ```env
   DATABASE_URL="postgresql://username:password@localhost:5432/utility_billing"
   ```

5. **Run database migrations:**
   ```
   npx prisma migrate dev --name init
   ```

6. **Start the application:**
   ```
   npm start
   ```

The server should be running on `http://localhost:3000`.

## Usage

### Input Meter Readings and Rates

Use the provided form to input meter readings for each utility type (day and night readings if applicable) as well as billing components.

### Generate Bills

Calculate and generate utility bills for a specified billing period.

### Monitor Consumption and Costs

View generated reports to monitor utility consumption and costs over time.

## License

This project is licensed under the MIT License.