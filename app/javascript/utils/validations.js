const required = v => !!v || 'Field is required';
const minLength = (v, length) => v.length >= length || `Min ${length}`;

export { required, minLength };
