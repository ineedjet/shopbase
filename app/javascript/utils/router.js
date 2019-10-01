import Vue from 'vue'
import VueRouter from 'vue-router'

import Staffs from '../components/staff/dashboard/staffs'
import Clients from '../components/staff/dashboard/clients'
import Organizations from '../components/staff/dashboard/organizations'
import Hardwares from '../components/staff/dashboard/hardwares'

Vue.use(VueRouter)
export default new VueRouter({
  mode: 'history',
  hashbang: false,
  routes: [
    { path: '/staffs', component: Staffs, name: 'Staffs' },
    { path: '/clients', component: Clients, name: 'Clients' },
    { path: '/organizations', component: Organizations, name: 'Organizations' },
    { path: '/hardwares', component: Hardwares, name: 'Hardwares' },
  ],
})
