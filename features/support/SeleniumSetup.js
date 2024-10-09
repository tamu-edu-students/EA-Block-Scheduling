// File: test/support/SeleniumSetup.js

const { setDefaultTimeout, AfterAll, BeforeAll } = require('@cucumber/cucumber');
const { Builder } = require('selenium-webdriver');

let driver;

// Set a default timeout (e.g., 60 seconds)
setDefaultTimeout(60 * 1000);

// Before all tests, set up the WebDriver
BeforeAll(async function () {
  driver = new Builder().forBrowser('chrome').build();
});

// After all tests, close the browser
AfterAll(async function () {
  await driver.quit();
});

module.exports = driver;