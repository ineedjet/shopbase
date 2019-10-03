import axios from 'axios';

const metaCsrfToken = document.querySelector('meta[name="csrf-token"]');
axios.defaults.headers.common = {
  'X-Requested-With': 'XMLHttpRequest',
  'X-CSRF-TOKEN': metaCsrfToken ? metaCsrfToken.getAttribute('content') : '',
};

const staffs_adapter = axios.create({
  baseURL: '/staffs',
});

export default {
  clients: {
    create: (client) => staffs_adapter.post('/clients', { client }),
    index: () => staffs_adapter.get('/clients'),
    update: (id, client) => staffs_adapter.put(`/clients/${id}`, { client }),
    validate: (client) => staffs_adapter.post('/clients/validate', { client }),
    destroy: (id) => staffs_adapter.delete(`/clients/${id}`),
    resetpass: (id) => staffs_adapter.post(`/clients/${id}/resetpass`),
  },
  staffs: {
    create: (staff) => staffs_adapter.post('/staffs', { staff }),
    index: () => staffs_adapter.get('/staffs'),
    update: (id, staff) => staffs_adapter.put(`/staffs/${id}`, { staff }),
    destroy: (id) => staffs_adapter.delete(`/staffs/${id}`),
    resetpass: (id) => staffs_adapter.post(`/staffs/${id}/resetpass`),
  },
  organizations: {
    create: (organization) => staffs_adapter.post('/organizations', { organization }),
    index: () => staffs_adapter.get('/organizations'),
    update: (id, organization) => staffs_adapter.put(`/organizations/${id}`, { organization }),
    destroy: (id) => staffs_adapter.delete(`/organizations/${id}`),
  },
  hardwares: {
    create: (hardware) => staffs_adapter.post('/hardwares', { hardware }),
    index: () => staffs_adapter.get('/hardwares'),
    update: (id, hardware) => staffs_adapter.put(`/hardwares/${id}`, { hardware }),
    destroy: (id) => staffs_adapter.delete(`/hardwares/${id}`),
  },
};
