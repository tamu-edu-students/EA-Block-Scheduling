const fs = require('fs');
const path = require('path');
const { JSDOM } = require('jsdom');
const html = fs.readFileSync(path.resolve('./Login_System.html'), 'utf8');

describe('Page load tests', () => {
    let document;

    beforeEach(() => {
        document = new JSDOM(html).window.document;
    });

    test('Header image is loaded correctly', () => {
        const headerImage = document.querySelector('img[alt="Header"]');
        expect(headerImage).not.toBeNull();
        expect(headerImage.getAttribute('src')).toBe('assets/Header.png');
    });

    test('Background image is set correctly in body', () => {
        const bodyStyle = document.querySelector('body').getAttribute('style');
        expect(bodyStyle).toContain("background-image: url('assets/LoginBackground.png')");
    });
});

describe('Button hover tests', () => {
    let document;

    beforeEach(() => {
        document = new JSDOM(html).window.document;
        // You may need to mock jQuery
        global.$ = require('jquery')(new JSDOM(html).window);
    });

    test('Login button changes color on hover', () => {
        const loginButton = document.getElementById('loginButton');

        // Simulate mouseenter event (hover)
        $(loginButton).trigger('mouseenter');
        expect(loginButton.style.backgroundColor).toBe('maroon');

        // Simulate mouseleave event (hover end)
        $(loginButton).trigger('mouseleave');
        expect(loginButton.style.backgroundColor).toBe('rgb(54, 18, 18)');  // #361212 in RGB format
    
    });

    test('Sign-up button changes color on hover', () => {
        const signUpButton = document.getElementById('signUpButton');

        // Simulate mouseenter event (hover)
        $(signUpButton).trigger('mouseenter');
        expect(signUpButton.style.backgroundColor).toBe('maroon');

        // Simulate mouseleave event (hover end)
        $(signUpButton).trigger('mouseleave');
        expect(signUpButton.style.backgroundColor).toBe('rgb(54, 18, 18)');
    });
});

describe('Text visibility test', () => {
    let document;

    beforeEach(() => {
        document = new JSDOM(html).window.document;
    });

    test('Text content exists and is visible', () => {
        const mainText = document.querySelector('main p');
        expect(mainText).not.toBeNull();
        expect(mainText.textContent).toBe('Howdy! Please log in or sign up to continue.');
    });
});


describe('Responsive design test', () => {
    let window, document;

    beforeEach(() => {
        window = new JSDOM(html).window;
        document = window.document;
    });

    test('Background image remains responsive', () => {
        const body = document.querySelector('body');
        window.innerWidth = 1280;

        expect(body.getAttribute('style')).toContain("background-size: cover");
        expect(body.getAttribute('style')).toContain("background-position: center");
    });
});

describe('Tab navigation tests', () => {
    let document;

    beforeEach(() => {
        document = new JSDOM(html).window.document;
    });

    test('Login button is focusable via tab navigation', () => {
        const loginButton = document.getElementById('loginButton');
        loginButton.focus();
        expect(document.activeElement).toBe(loginButton);
    });

    test('Sign-up button is focusable via tab navigation', () => {
        const signUpButton = document.getElementById('signUpButton');
        signUpButton.focus();
        expect(document.activeElement).toBe(signUpButton);
    });
});

describe('Accessibility tests', () => {
    let document;

    beforeEach(() => {
        document = new JSDOM(html).window.document;
    });

    test('Header image has an alt attribute for accessibility', () => {
        const headerImage = document.querySelector('img[alt="Header"]');
        expect(headerImage).not.toBeNull();
        expect(headerImage.getAttribute('alt')).toBe('Header');
    });
});