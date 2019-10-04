<template lang="pug">
  q-form.bg-white.m-2.p-4.rounded.shadow-lg(ref='form')
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

    .submit
      q-btn(type="submit" color="primary" label="Create" @click="save()")
</template>

<script>
import { required } from '../../../../utils/validations';
import { clone } from '../../../../utils/object';

const emptyOrganization = {
      name: '',
      kind: '',
      inn: '',
      ogrn: '',
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
      }
    }
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
      };
      if (this.formOrganization.id) {
        var api_action = this.$api.organizations.update(this.formOrganization.id, organizationForApi);
      } else {
        var api_action = this.$api.organizations.create(organizationForApi);
      }
      api_action.then(
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
    required,
  },
  watch: {
    organization: function() {
      this.formOrganization = clone(this.organization);
    }
  }
}
</script>