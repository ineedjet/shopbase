import axios from 'axios';
import qs from 'qs';

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
    show: (id) => staffs_adapter.get(`/clients/${id}`),
    update: (id, client) => staffs_adapter.put(`/clients/${id}`, { client }),
    validate: (client) => staffs_adapter.post('/clients/validate', { client }),
    destroy: (id) => staffs_adapter.delete(`/clients/${id}`),
    resetpass: (id) => staffs_adapter.post(`/clients/${id}/resetpass`),
  },
  staffs: {
    create: (staff) => staffs_adapter.post('/staffs', { staff }),
    index: () => staffs_adapter.get('/staffs'),
    show: (id) => staffs_adapter.get(`/staffs/${id}`),
    update: (id, staff) => staffs_adapter.put(`/staffs/${id}`, { staff }),
    destroy: (id) => staffs_adapter.delete(`/staffs/${id}`),
    resetpass: (id) => staffs_adapter.post(`/staffs/${id}/resetpass`),
  },
  organizations: {
    create: (organization) => staffs_adapter.post('/organizations', { organization }),
    index: (props) => staffs_adapter.get('/organizations?' + qs.stringify(props)),
    show: (id) => staffs_adapter.get(`/organizations/${id}`),
    update: (id, organization) => staffs_adapter.put(`/organizations/${id}`, { organization }),
    destroy: (id) => staffs_adapter.delete(`/organizations/${id}`),
  },
  devices: {
    create: (device) => staffs_adapter.post('/devices', { device }),
    index: () => staffs_adapter.get('/devices'),
    show: (id) => staffs_adapter.get(`/devices/${id}`),
    update: (id, device) => staffs_adapter.put(`/devices/${id}`, { device }),
    destroy: (id) => staffs_adapter.delete(`/devices/${id}`),
  },
};
