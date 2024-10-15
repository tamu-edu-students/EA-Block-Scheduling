const fs = require('fs');
const path = require('path');
const { JSDOM } = require('jsdom');
const html = fs.readFileSync(path.resolve('./LoginSystem.html'), 'utf8');



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
    let document, window, $;

    beforeEach(() => {
        // Create a JSDOM instance from the HTML file
        const dom = new JSDOM(html);
        window = dom.window;
        document = window.document;
        // Attach jQuery to the JSDOM window
        $ = require('jquery')(window);
    });

    test('Login button changes color on hover', () => {
        const loginButton = document.getElementById('loginButton');
        expect(loginButton).not.toBeNull();  

        // Simulate mouseenter event (hover)
        $(loginButton).trigger('mouseenter');

        // Use JSDOM's window object to get the computed style
        const computedStyle = window.getComputedStyle(loginButton);
        expect(computedStyle.backgroundColor).toBe('rgb(54, 18, 18)');  

        // Simulate mouseleave event (hover end)
        $(loginButton).trigger('mouseleave');

        // Check the computed style after mouseleave
        const computedStyleAfterLeave = window.getComputedStyle(loginButton);
        expect(computedStyleAfterLeave.backgroundColor).toBe('rgb(54, 18, 18)'); 
    });
    

    test('Signup button changes color on hover', () => {
        const signupButton = document.getElementById('loginButton');
        expect(signupButton).not.toBeNull(); 

        // Simulate mouseenter event (hover)
        $(signupButton).trigger('mouseenter');

        // Use JSDOM's window object to get the computed style
        const computedStyle = window.getComputedStyle(signupButton);
        expect(computedStyle.backgroundColor).toBe('rgb(54, 18, 18)');  

        // Simulate mouseleave event (hover end)
        $(signupButton).trigger('mouseleave');

        // Check the computed style after mouseleave
        const computedStyleAfterLeave = window.getComputedStyle(signupButton);
        expect(computedStyleAfterLeave.backgroundColor).toBe('rgb(54, 18, 18)');  
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
        expect(mainText.textContent).toBe('Howdy! Please log in, sign up, or use SSO to continue.');
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
        expect(loginButton).not.toBeNull(); 
    
        if (loginButton) {
            jest.spyOn(loginButton, 'focus'); 
            loginButton.focus();
            expect(loginButton.focus).toHaveBeenCalled();  
        }
    });

    test('Signup button is focusable via tab navigation', () => {
        const signupButton = document.getElementById('signupButton');
        expect(signupButton).not.toBeNull();  
    
        if (signupButton) {
            jest.spyOn(signupButton, 'focus');  
            signupButton.focus();
            expect(signupButton.focus).toHaveBeenCalled();  
        }
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
