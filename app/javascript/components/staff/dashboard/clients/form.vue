<template lang="pug">
  q-form.bg-white.m-2.p-4.rounded.shadow-lg(ref='form')
    h5.font-bold.text-2xl {{ title }}

    input(type="hidden" id="id" name="id" :value="formClient.id")
    
    .form-group
      q-input(v-model.trim="formClient.email" label="Email" 
        ref="email"
        clearable
        clear-icon="fas fa-window-close"
        :rules="[required, email]"
        )
      span.error(v-for="error in errors.email") {{ error }}

    .form-group
      q-input(v-model.trim="formClient.fullname" label="Имя" 
        ref="fullname"
        clearable
        clear-icon="fas fa-window-close"
        :rules="[required, val => minLength(val, 5)]"
        )
      span.error(v-for="error in errors.fullname") {{ error }}
      
    .form-group
      q-input(v-model.trim="formClient.phone" label="Телефон"
        ref="phone"
        clearable
        clear-icon="fas fa-window-close"
        :rules="[required, phoneCheck]"
        )
      span.error(v-for="error in errors.phone") {{ error }}

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
    }

export default {
  props: {
    title: String,
    client: { 
      type: Object,
      default: function () { return clone(emptyClient) },
    },
    action: String,
  },
  data: function() {
    return {
      formClient: {},
      errors: {
        email: [],
        fullname: [],
        phone: [],
      }
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
      };
      if (this.action === "create") {
        var api_action = this.$api.clients.create(clientForApi);
      } else if (this.action === "update") {
        var api_action = this.$api.clients.update(this.formClient.id, clientForApi);
      }
      api_action.then(
        response => {
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
    required,
    minLength,
    email,
    phoneCheck,
  }
}
</script>
