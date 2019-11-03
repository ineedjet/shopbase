<template lang="pug">
  q-form.bg-white.m-2.p-4.rounded.shadow-lg(ref='form')
    h5.font-bold.text-2xl
      span(v-if="this.formDevice.id") Edit Device
      span(v-else) Create Device
    
    .form-group
      q-input(v-model.trim="formDevice.name" label="Название" 
        ref="name"
        clearable
        clear-icon="fas fa-window-close"
        :rules="[required]"
        )
      span.error(v-for="error in errors.name") {{ error }}

    .form-group
      q-input(v-model.trim="formDevice.kind" label="Тип оборудования"
        ref="kind"
        clearable
        clear-icon="fas fa-window-close"
        :rules="[required]"
        )
      span.error(v-for="error in errors.kind") {{ error }}
    
    .form-group
      q-input(v-model.number="formDevice.number" label="Номер"
        ref="number"
        type="number"
        :rules="[required]"
        )
      span.error(v-for="error in errors.number") {{ error }}

    .form-group
      q-select(
        v-model="selectedOrganization"
        :options="organizations"
        label="Организация"
        outlined
        )

    .submit
      q-btn(type="submit" color="primary" label="Save" @click="save()")
</template>

<script>
import { required } from 'utils/validations';
import { clone } from 'utils/object';

const emptyDevice = {
      name: '',
      kind: '',
      number: '',
      organization: null,
    }

export default {
  props: {
    device: { 
      type: Object,
      default: function () { return clone(emptyDevice) },
    },
  },
  data: function() {
    return {
      formDevice: {},
      errors: {
        name: [],
        kind: [],
        number: [],
      },
      organizations: this.getOrganizations(),
      selectedOrganization: {},
    }
  },
  methods: {
    clearForm() {
      this.formDevice = clone(emptyDevice);
      this.errors = {
        name: [],
        kind: [],
        number: [],
      };
    },
    sendForm() {
      let deviceForApi = {
        name: this.formDevice.name,
        kind: this.formDevice.kind,
        number: this.formDevice.number,
        organization_id: this.selectedOrganization.value,
      };
      if (this.formDevice.id) {
        var apiAction = this.$api.devices.update(this.formDevice.id, deviceForApi);
      } else {
        var apiAction = this.$api.devices.create(deviceForApi);
      }
      apiAction.then(
        response => {
          this.$eventBus.$emit('needCloseDialog');
          this.$eventBus.$emit('needUpdateDeviceList');
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
      this.$refs.number.validate();
      return (this.$refs.name.hasError || 
              this.$refs.kind.hasError || 
              this.$refs.number.hasError);
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
    getOrganizations() {
      this.$api.organizations
        .index()
        .then(
          response => {
            this.organizations = response.data.data.map(i => {
              return { 'value': i.attributes.id, 'label': i.attributes.name };
            });
            // setup dropdown multi-selector:
            if (this.formDevice.organization) {
              let deviceId = this.formDevice.organization.id
              this.selectedOrganization = this.organizations.find( (org) => { return (deviceId === org.value) });
            }
          }
        )
    },
    required,
  },
  watch: {
    device: function() {
      this.formDevice = clone(this.device);
    }
  }
}
</script>
