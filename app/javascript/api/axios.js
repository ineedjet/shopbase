import axios from 'axios';

const metaCsrfToken = document.querySelector('meta[name="csrf-token"]');
axios.defaults.headers.common = {
  'X-Requested-With': 'XMLHttpRequest',
  'X-CSRF-TOKEN': metaCsrfToken ? metaCsrfToken.getAttribute('content') : '',
};

const adapter = axios.create({
  baseURL: '/',
});

export default {
  post: (client) => adapter.post('/staffs/clients', { client }),
  get_index: () => adapter.get('/staffs/clients'),
  validate: (client) => adapter.post('/staff/clients/validate', { client }),
};
