const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
const phoneRegex= /(?:\(?\+\d{2}\)?\s*)?\d+(?:[ -]*\d+)*$/;

const required = v => !!v || 'Field is required';
const minLength = (v, length) => v.length >= length || `Min ${length}`;
const email = v => emailRegex.test(v) || 'Please enter a valid email address';
const phoneCheck = v => phoneRegex.test(v) || 'Please enter a valid phone number';

export { required, minLength, email, phoneCheck };
