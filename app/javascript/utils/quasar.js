import Vue from 'vue'

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

export default {
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
};
