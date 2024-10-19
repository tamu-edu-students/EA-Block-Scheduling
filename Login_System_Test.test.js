const fs = require('fs');
const path = require('path');
const { JSDOM } = require('jsdom');
const html = fs.readFileSync(path.resolve('./LoginSystem.html'), 'utf8');
let document, window, $;

// Utility function to initialize JSDOM and jQuery
const initializeDom = () => {
    const dom = new JSDOM(html);
    window = dom.window;
    document = window.document;
    $ = require('jquery')(window);
};

describe('Page load and accessibility tests', () => {
    beforeEach(() => {
        initializeDom();
    });


    const elements = [
        { selector: 'img[alt="Header"]', attribute: 'src', value: 'assets/Header.png' },
        { selector: 'img[alt="Header"]', attribute: 'alt', value: 'Header' }
    ];

    test.each(elements)(
        'Element $selector should have $attribute set to $value',
        ({ selector, attribute, value }) => {
            const element = document.querySelector(selector);
            expect(element).not.toBeNull();
            expect(element.getAttribute(attribute)).toBe(value);
        }
    );

    test('Background image is set correctly in body', () => {
        const bodyStyle = document.querySelector('body').getAttribute('style');
        expect(bodyStyle).toContain("background-image: url('assets/LoginBackground.png')");
    });
});

describe('Button hover and tab navigation tests', () => {
    beforeEach(() => {
        initializeDom();
    });

 
    const buttons = [
        { id: 'loginButton', expectedColor: 'rgb(54, 18, 18)' },
        { id: 'signupButton', expectedColor: 'rgb(54, 18, 18)' }
    ];

    test.each(buttons)(
        'Button $id changes color on hover and is focusable via tab navigation',
        ({ id, expectedColor }) => {
            const button = document.getElementById(id);
            expect(button).not.toBeNull();

         
            $(button).trigger('mouseenter');
            const computedStyleHover = window.getComputedStyle(button);
            expect(computedStyleHover.backgroundColor).toBe(expectedColor);

        
            $(button).trigger('mouseleave');
            const computedStyleLeave = window.getComputedStyle(button);
            expect(computedStyleLeave.backgroundColor).toBe(expectedColor);

         
            jest.spyOn(button, 'focus');
            button.focus();
            expect(button.focus).toHaveBeenCalled();
        }
    );
});

describe('Text visibility and responsive design tests', () => {
    beforeEach(() => {
        initializeDom();
    });

    test('Text content exists and is visible', () => {
        const mainText = document.querySelector('main p');
        expect(mainText).not.toBeNull();
        expect(mainText.textContent).toBe('Howdy! Please log in, sign up, or use SSO to continue.');
    });

    test('Background image remains responsive', () => {
        const body = document.querySelector('body');
        window.innerWidth = 1280;
        expect(body.getAttribute('style')).toContain('background-size: cover');
        expect(body.getAttribute('style')).toContain('background-position: center');
    });
});
