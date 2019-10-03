import Vue from 'vue'
import Staff from '../components/staff'
import Api from '../api/axios'
import router from '../utils/router'
Vue.prototype.$eventBus = new Vue();
Vue.prototype.$api = Api;

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    render: h => h(Staff, {
      props: {
        userEmail: document.body.getAttribute('data-user-email')
      },
    }),
    router,
  }).$mount()
  document.body.appendChild(app.$el)
})

// QUASAR

import iconSet from 'quasar/icon-set/fontawesome-v5.js'
import '@quasar/extras/fontawesome-v5/fontawesome-v5.css'

import '../assets/styles/quasar.styl'
import 'quasar/dist/quasar.ie.polyfills'

import {
  Quasar,
  QLayout,
  QHeader,
  QDrawer,
  QPageContainer,
  QPage,
  QSpinner,
  QTable,
  QTh,
  QTr,
  QTd,
  QSpinnerBars,
  QToolbar,
  QToolbarTitle,
  QForm,
  QField,
  QInput,
  QBtnGroup,
  QBtn,
  Notify,
  QDialog,
  QCard,
  QCardSection,
  QCardActions,
  QSeparator,
  ClosePopup,
} from 'quasar'

Vue.use(Quasar, {
  components: {
    QLayout,
    QHeader,
    QDrawer,
    QPageContainer,
    QPage,
    QSpinner,
    QTable,
    QTh,
    QTr,
    QTd,
    QSpinnerBars,
    QToolbar,
    QToolbarTitle,
    QForm,
    QField,
    QInput,
    QBtnGroup,
    QBtn,
    QDialog,
    QCard,
    QCardSection,
    QCardActions,
    QSeparator,
  },
  plugins: {
    Notify,
  },
  directives: {
    ClosePopup,
  },
  config: {},
  iconSet: iconSet,
});
