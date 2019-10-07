import Vue from 'vue'
import Vuex from 'vuex'
import VuexPersistedState from 'vuex-persistedstate'

Vue.use(Vuex)

import organizationFilter from './modules/organization-filter'

export default new Vuex.Store({
  state: {
    currentUser: null,
  },
  mutations: {},
  actions: {},
  modules: {
    organizationFilter,
  },
  plugins: [
    VuexPersistedState(),
  ],
})
