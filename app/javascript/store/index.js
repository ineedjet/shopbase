import Vue from 'vue'
import Vuex from 'vuex'
import VuexPersistedState from 'vuex-persistedstate'

Vue.use(Vuex)

import organizations from './modules/organizations'
import organizationFilter from './modules/organization-filter'

export default new Vuex.Store({
  state: {
    currentUser: null,
  },
  mutations: {},
  actions: {},
  modules: {
    organizations,
    organizationFilter,
  },
  plugins: [
    VuexPersistedState(),
  ],
})
