<template lang="pug">
  q-form.m-2.p-4.rounded.shadow-lg.bg-gray-800.text-gray-100(ref='form')
    h5.font-bold.text-2xl
      span(v-if="this.formClient.id") Edit Client
      span(v-else) Create Client

    input(type="hidden" id="id" name="id" :value="formClient.id")
    
    .form-group
      q-input(v-model.trim="formClient.email" label="Email" 
        ref="email"
        clearable
        clear-icon="fas fa-window-close"
        :rules="[required, email]"
        dark outlined
        )
      span.error(v-for="error in errors.email") {{ error }}

    .form-group
      q-input(v-model.trim="formClient.fullname" label="Имя" 
        ref="fullname"
        clearable
        clear-icon="fas fa-window-close"
        :rules="[required, val => minLength(val, 5)]"
        dark outlined
        )
      span.error(v-for="error in errors.fullname") {{ error }}
      
    .form-group
      q-input(v-model.trim="formClient.phone" label="Телефон"
        ref="phone"
        clearable
        clear-icon="fas fa-window-close"
        :rules="[required, phoneCheck]"
        dark outlined
        )
      span.error(v-for="error in errors.phone") {{ error }}

    .form-group
      q-select(
        v-model="selectedOrganizations"
        multiple
        :options="organizations"
        label="Организации"
        dark outlined
        )

    .submit
      q-btn(type="submit" color="primary" label="Save" @click="save()")

</template>

<script>
import { required, minLength, email, phoneCheck } from '../../../../utils/validations';
import { clone } from '../../../../utils/object';

const emptyClient = {
      email: '',
      fullname: '',
      phone: '',
      organizations: '',
    }

export default {
  props: {
    client: { 
      type: Object,
      default: function () { return clone(emptyClient) },
    },
  },
  data: function() {
    return {
      formClient: {},
      errors: {
        email: [],
        fullname: [],
        phone: [],
      },
      organizations: this.getOrganizations(),
      selectedOrganizations: null,
    }
  },
  computed: {
    idsSelectedOrganizations: function() {
      return Array.from(this.selectedOrganizations, ({value}) => { return value });
    }
  },
  created: function() {
    this.formClient = clone(this.client);
  },
  methods: {
    clearForm() {
      this.formClient = clone(emptyClient);
      this.errors = {
        email: [],
        fullname: [],
        phone: [],
      };
    },
    sendForm() {
      let clientForApi = {
        email: this.formClient.email,
        fullname: this.formClient.fullname,
        phone: this.formClient.phone,
        organization_ids: this.idsSelectedOrganizations,
      };
      if (this.formClient.id) {
        var apiAction = this.$api.clients.update(this.formClient.id, clientForApi);
      } else {
        var apiAction = this.$api.clients.create(clientForApi);
      }
      apiAction.then(
        response => {
          this.$eventBus.$emit('needCloseDialog');
          this.$eventBus.$emit('needUpdateClientList');
          this.clearForm();
          this.$q.notify({
            icon: 'fas fa-check',
            color: 'positive',
            message: 'Saved'
          });
        },
        errors => {
          this.errors = errors.response.data;
          this.$q.notify({
            color: 'negative',
            message: 'Couldn\'t save this form.'
          });
        }
      ).finally(()=>{
        if (this.$refs.form) {
          this.$nextTick(() => {
            this.$refs.form.resetValidation();
          });
        }
      });
    },
    formHasErrors() {
      this.$refs.fullname.validate();
      this.$refs.phone.validate();
      return (this.$refs.fullname.hasError || 
              this.$refs.phone.hasError);
    },
    save() {
      if (this.formHasErrors()) {
        this.$q.notify({
          color: 'negative',
          message: 'Can\'t send it. Some error(s) in form.'
        })
      } else {
        this.sendForm();
        this.$emit('sended');
      }
    },
    getOrganizations() {
      this.$api.organizations
        .index()
        .then(
          response => {
            this.organizations = response.data.data.map(i => {
              return { 'value': i.attributes.id, 'label': i.attributes.name };
            });
            // setup dropdown multi-selector:
            let localOrganizationIds = Array.from(this.formClient.organizations, ({id}) => { return id })
            this.selectedOrganizations = this.organizations.filter( ({value}) => { return localOrganizationIds.includes(value) });
          }
        )
    },
    required,
    minLength,
    email,
    phoneCheck,
  },
  watch: {
    client: function() {
      this.formClient = clone(this.client);
    },
  },
}
</script>
