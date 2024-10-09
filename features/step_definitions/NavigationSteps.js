const { Given, When, Then } = require('@cucumber/cucumber');
const { Builder, By, until } = require('selenium-webdriver');
let driver;

Given('I am on the main page', async function() {
  driver = await new Builder().forBrowser('chrome').build();
  await driver.get('LoginSystem.html');
});

When('I click the {string} button', async function(buttonText) {
  let button;
  if (buttonText === 'Login') {
    button = await driver.findElement(By.css('.login-btn'));
  } else if (buttonText === 'Sign Up') {
    button = await driver.findElement(By.css('.sign-up-btn'));
  }
  await button.click();
});

Then('I should be redirected to the login page', async function() {
  await driver.wait(until.urlContains('Login_Screen.html'), 10000);
  let url = await driver.getCurrentUrl();
  if (!url.includes('Login_Screen.html')) {
    throw new Error('Not redirected to login page');
  }
});

Then('I should be redirected to the sign-up page', async function() {
  await driver.wait(until.urlContains('Signup.html'), 10000);
  let url = await driver.getCurrentUrl();
  if (!url.includes('Signup.html')) {
    throw new Error('Not redirected to sign-up page');
  }
});
