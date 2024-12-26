-- إنشاء قاعدة البيانات
CREATE DATABASE bank_db;
USE bank_db;

-- جدول البنوك
CREATE TABLE Banks (
    BankID INT PRIMARY KEY IDENTITY(1,1),
    BankName NVARCHAR(100) NOT NULL,
    BankAddress NVARCHAR(200)
);

-- جدول الأشخاص
CREATE TABLE Persons (
    PersonID INT PRIMARY KEY IDENTITY(1,1),
    FullName NVARCHAR(100) NOT NULL,
    PhoneNumber NVARCHAR(20),
    Email NVARCHAR(100)
);

-- جدول الحسابات البنكية
CREATE TABLE BankAccounts (
    AccountID INT PRIMARY KEY IDENTITY(1,1),
    AccountNumber NVARCHAR(50) NOT NULL,
    BankID INT FOREIGN KEY REFERENCES Banks(BankID),
    PersonID INT FOREIGN KEY REFERENCES Persons(PersonID),
    AccountType NVARCHAR(10) CHECK (AccountType IN ('Savings', 'Checking')),
    Balance DECIMAL(18,2)
);

-- جدول المعاملات
CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY IDENTITY(1,1),
    AccountID INT FOREIGN KEY REFERENCES BankAccounts(AccountID),
    TransactionType NVARCHAR(20),
    Amount DECIMAL(18,2),
    TransactionDate DATETIME,
    RelatedAccountID INT
);

-- إضافة عميل جديد
CREATE PROCEDURE AddPerson
    @FullName NVARCHAR(100),
    @PhoneNumber NVARCHAR(20),
    @Email NVARCHAR(100)
AS
BEGIN
    INSERT INTO Persons (FullName, PhoneNumber, Email)
    VALUES (@FullName, @PhoneNumber, @Email);
END

-- إجراء إيداع
CREATE PROCEDURE DepositMoney
    @AccountID INT,
    @Amount DECIMAL(18,2)
AS
BEGIN
    UPDATE BankAccounts
    SET Balance = Balance + @Amount
    WHERE AccountID = @AccountID;
END

-- ... باقي الإجراءات المخزنة
-- عرض جميع حسابات شخص معين
SELECT * FROM BankAccounts
WHERE PersonID = 1;

-- عرض تاريخ المعاملات لحساب معين
SELECT * FROM Transactions
WHERE AccountID = 123
ORDER BY TransactionDate DESC;
