import Vue from 'vue'
import VueRouter from 'vue-router'

import Staffs from '../components/staff/dashboard/staffs'
import StaffForm from '../components/staff/dashboard/staffs/form'
import Clients from '../components/staff/dashboard/clients'
import ClientForm from '../components/staff/dashboard/clients/form'
import Organizations from '../components/staff/dashboard/organizations'
import Hardwares from '../components/staff/dashboard/hardwares'

Vue.use(VueRouter)
export default new VueRouter({
  mode: 'history',
  hashbang: false,
  routes: [
    { path: '/staffs/dashboard/staffs', component: Staffs,
      meta: { showDialog: false },
      children: [
        { 
          path: ':id/edit',
          components: {
            default: Staffs,
            editForm: StaffForm,
          },
          meta: { showDialog: true },
        },
      ]
    },
    { path: '/staffs/dashboard/clients', component: Clients,
      // children: [
      //   {
      //     path: ':id/edit', 
      //     components: {
      //       page: Clients,
      //       editForm: ClientForm,
      //     },
      //     meta: { showDialog: true },
      //   },
      // ]
    },
    { path: '/staffs/dashboard/organizations', component: Organizations },
    { path: '/staffs/dashboard/hardwares', component: Hardwares, name: 'Hardwares' },
  ],
})
