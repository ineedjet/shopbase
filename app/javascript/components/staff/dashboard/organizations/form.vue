<template lang="pug">
  q-form.bg-white.m-2.p-4.rounded.shadow-lg(ref='form' style="min-width: 30vw")
    h5.font-bold.text-2xl
      span(v-if="this.formOrganization.id") Edit Organization
      span(v-else) Create Organization
    
    .form-group
      q-input(v-model.trim="formOrganization.name" label="Название" 
        ref="name"
        clearable
        clear-icon="fas fa-window-close"
        :rules="[required]"
        )
      span.error(v-for="error in errors.name") {{ error }}

    .form-group
      q-input(v-model.trim="formOrganization.kind" label="Форма организации"
        ref="kind"
        clearable
        clear-icon="fas fa-window-close"
        :rules="[required]"
        )
      span.error(v-for="error in errors.kind") {{ error }}
    
    .form-group
      q-input(v-model.number="formOrganization.inn" label="ИНН"
        ref="inn"
        type="number"
        :rules="[required]"
        )
      span.error(v-for="error in errors.inn") {{ error }}
    
    .form-group
      q-input(v-model.number="formOrganization.ogrn" label="ОГРН"
        ref="ogrn"
        type="number"
        :rules="[required]"
        )
      span.error(v-for="error in errors.ogrn") {{ error }}

    .form-group
      q-select(
        v-model="selectedClients"
        multiple
        :options="clients"
        label="Клиенты"
        outlined
        )
      
    .form-group
      q-select(
        v-model="selectedDevices"
        multiple
        :options="devices"
        label="Девайсы"
        outlined
        )

    .submit
      q-btn(type="submit" color="primary" label="Create" @click="save()")
</template>

<script>
import { required } from 'utils/validations';
import { clone } from 'utils/object';

const emptyOrganization = {
      name: '',
      kind: '',
      inn: '',
      ogrn: '',
      clients: '',
      devices: '',
    }

export default {
  props: {
    organization: { 
      type: Object,
      default: function () { return clone(emptyOrganization) },
    },
  },
  data: function() {
    return {
      formOrganization: {},
      errors: {
        name: [],
        kind: [],
        inn: [],
        ogrn: [],
      },
      clients: this.getClients(),
      selectedClients: null,
      devices: this.getDevices(),
      selectedDevices: null,
    }
  },
  computed: {
    idsSelectedClients: function() {
      return Array.from(this.selectedClients, ({value}) => {return value} );
    },
    idsSelectedDevices: function() {
      return Array.from(this.selectedDevices, ({value}) => {return value} );
    },
  },
  created: function() {
    this.formOrganization = clone(this.organization);
  },
  methods: {
    clearForm() {
      this.formOrganization = clone(emptyOrganization);
      this.errors = {
        name: [],
        kind: [],
        inn: [],
        ogrn: [],
      };
    },
    sendForm() {
      let organizationForApi = {
        name: this.formOrganization.name,
        kind: this.formOrganization.kind,
        inn: this.formOrganization.inn,
        ogrn: this.formOrganization.ogrn,
        client_ids: this.idsSelectedClients,
        device_ids: this.idsSelectedDevices,
      };
      if (this.formOrganization.id) {
        var apiAction = this.$api.organizations.update(this.formOrganization.id, organizationForApi);
      } else {
        var apiAction = this.$api.organizations.create(organizationForApi);
      }
      apiAction.then(
        response => {
          this.$eventBus.$emit('needCloseDialog');
          this.$eventBus.$emit('needUpdateOrganizationList');
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
      this.$refs.name.validate();
      this.$refs.kind.validate();
      this.$refs.inn.validate();
      this.$refs.ogrn.validate();
      return (this.$refs.name.hasError || 
              this.$refs.kind.hasError || 
              this.$refs.inn.hasError || 
              this.$refs.ogrn.hasError);
    },
    save() {
      if (this.formHasErrors()) {
        this.$q.notify({
          color: 'negative',
          message: 'Can\'t send it. Some error(s) in form.'
        })
      } else {
        this.sendForm();
      }
    },
    getClients() {
      this.$api.clients
        .index()
        .then(
          response => {
            this.clients = response.data.data.map(i => {
              return { 'label': i.attributes.fullname, 'value': i.attributes.id}
            });

            // setup dropdown multi-selector for Clients:
            let clientIds = Array.from(this.formOrganization.clients, client => { return client.id })
            this.selectedClients = this.clients.filter(client => { return clientIds.includes(client.value) });
          }
        )
    },
    getDevices() {
      this.$api.devices
        .index()
        .then(
          response => {
            this.devices = response.data.data.map(i => {
              return { 'label': i.attributes.name, 'value': i.attributes.id}
            });

            // setup dropdown multi-selector for Devices:
            let deviceIds = Array.from(this.formOrganization.devices, device => { return device.id })
            this.selectedDevices = this.devices.filter(device => { return deviceIds.includes(device.value) });
          }
        )
    },
    required,
  },
  watch: {
    organization: function() {
      this.formOrganization = clone(this.organization);
    }
  }
}
</script>
