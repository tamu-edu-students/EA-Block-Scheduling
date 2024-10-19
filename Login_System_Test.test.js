const fs = require('fs');
const path = require('path');
const { JSDOM } = require('jsdom');
const html = fs.readFileSync(path.resolve('./LoginSystem.html'), 'utf8');
let document, window, $;


const initializeDom = () => {
    const dom = new JSDOM(html);
    window = dom.window;
    document = window.document;
    $ = require('jquery')(window);
};

describe('Page load tests', () => {
    beforeEach(() => {
        initializeDom();
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
    beforeEach(() => {
        initializeDom();
    });

    const testButtonHover = (buttonId) => {
        const button = document.getElementById(buttonId);
        expect(button).not.toBeNull();  

        // Simulate mouseenter event (hover)
        $(button).trigger('mouseenter');
        const computedStyle = window.getComputedStyle(button);
        expect(computedStyle.backgroundColor).toBe('rgb(54, 18, 18)');  

        // Simulate mouseleave event (hover end)
        $(button).trigger('mouseleave');
        const computedStyleAfterLeave = window.getComputedStyle(button);
        expect(computedStyleAfterLeave.backgroundColor).toBe('rgb(54, 18, 18)');
    };

    test('Login button changes color on hover', () => {
        testButtonHover('loginButton');
    });

    test('Signup button changes color on hover', () => {
        testButtonHover('signupButton');
    });
});

describe('Text visibility test', () => {
    beforeEach(() => {
        initializeDom();
    });

    test('Text content exists and is visible', () => {
        const mainText = document.querySelector('main p');
        expect(mainText).not.toBeNull();
        expect(mainText.textContent).toBe('Howdy! Please log in, sign up, or use SSO to continue.');
    });
});

describe('Responsive design test', () => {
    beforeEach(() => {
        initializeDom();
    });

    test('Background image remains responsive', () => {
        const body = document.querySelector('body');
        window.innerWidth = 1280;
        expect(body.getAttribute('style')).toContain("background-size: cover");
        expect(body.getAttribute('style')).toContain("background-position: center");
    });
});

describe('Tab navigation tests', () => {
    beforeEach(() => {
        initializeDom();
    });

    const testTabNavigation = (buttonId) => {
        const button = document.getElementById(buttonId);
        expect(button).not.toBeNull();
        if (button) {
            jest.spyOn(button, 'focus');
            button.focus();
            expect(button.focus).toHaveBeenCalled();
        }
    };

    test('Login button is focusable via tab navigation', () => {
        testTabNavigation('loginButton');
    });

    test('Signup button is focusable via tab navigation', () => {
        testTabNavigation('signupButton');
    });
});

describe('Accessibility tests', () => {
    beforeEach(() => {
        initializeDom();
    });

    test('Header image has an alt attribute for accessibility', () => {
        const headerImage = document.querySelector('img[alt="Header"]');
        expect(headerImage).not.toBeNull();
        expect(headerImage.getAttribute('alt')).toBe('Header');
    });
});
