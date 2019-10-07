import Vue from 'vue'
import VueRouter from 'vue-router'

import Staffs from '../components/staff/dashboard/staffs'
import StaffEdit from '../components/staff/dashboard/staffs/edit-dialog'

import Clients from '../components/staff/dashboard/clients'
import ClientEdit from '../components/staff/dashboard/clients/edit-dialog'

import Organizations from '../components/staff/dashboard/organizations'
import OrganizationEdit from '../components/staff/dashboard/organizations/edit-dialog'

import Devices from '../components/staff/dashboard/devices'
import DeviceEdit from '../components/staff/dashboard/devices/edit-dialog'

Vue.use(VueRouter)
export default new VueRouter({
  mode: 'history',
  hashbang: false,
  routes: [
    { path: '/staffs/dashboard/staffs', component: Staffs,
      children: [
        { 
          path: ':id/edit',
          components: {
            editForm: StaffEdit,
          },
        },
      ]
    },
    { path: '/staffs/dashboard/clients', component: Clients,
      children: [
        {
          path: ':id/edit', 
          components: {
            editForm: ClientEdit,
          },
        }
      ]
    },
    { path: '/staffs/dashboard/organizations', component: Organizations,
      children: [
        {
          path: ':id/edit', 
          components: {
            editForm: OrganizationEdit,
          },
        }
      ]
    },
    { path: '/staffs/dashboard/devices', component: Devices,
      children: [
        {
          path: ':id/edit', 
          components: {
            editForm: DeviceEdit,
          },
        }
      ]
    },
  ],
})
