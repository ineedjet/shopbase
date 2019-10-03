<template lang="pug">
  q-form.bg-white.m-2.p-4.rounded.shadow-lg(ref='form')
    h5.font-bold.text-2xl {{ title }}

    input(type="hidden" id="id" name="id" :value="formStaff.id")
    
    .form-group
      q-input(v-model.trim="formStaff.email" label="Email" 
        ref="email"
        clearable
        clear-icon="fas fa-window-close"
        :rules="[required, email]"
        )
      span.error(v-for="error in errors.email") {{ error }}
    
    .form-group
      q-input(v-model.trim="formStaff.fullname" label="Имя" 
        ref="fullname"
        clearable
        clear-icon="fas fa-window-close"
        :rules="[required, val => minLength(val, 5)]"
        )
      span.error(v-for="error in errors.fullname") {{ error }}

    .form-group
      q-input(v-model.trim="formStaff.position" label="Должность"
        ref="position"
        clearable
        clear-icon="fas fa-window-close"
        :rules="[required]"
        )
      span.error(v-for="error in errors.position") {{ error }}
    
    .submit
      q-btn(type="submit" color="primary" label="Save" @click="save()")
</template>

<script>
import { required, minLength, email } from '../../../../utils/validations';
import { clone } from '../../../../utils/object';

const emptyStaff = {
      email: '',
      fullname: '',
      position: '',
    }

export default {
  props: {
    title: String,
    staff: { 
      type: Object,
      default: function () { return clone(emptyStaff) },
    },
    action: String,
  },
  data: function() {
    return {
      formStaff: {},
      errors: {
        email: [],
        fullname: [],
        position: [],
      }
    }
  },
  created: function() {
    this.formStaff = clone(this.staff);
  },
  methods: {
    clearForm() {
      this.formStaff = clone(emptyStaff);
      this.errors = {
        email: [],
        fullname: [],
        position: [],
      };
    },
    sendForm() {
      let staffForApi = {
        email: this.formStaff.email,
        fullname: this.formStaff.fullname,
        position: this.formStaff.position,
      };
      if (this.action === "create") {
        var api_action = this.$api.staffs.create(staffForApi);
      } else if (this.action === "update") {
        console.log("this.formStaff.id = ", this.formStaff.id);
        console.log("staffForApi = ", staffForApi);
        var api_action = this.$api.staffs.update(this.formStaff.id, staffForApi);
      }
      api_action.then(
        response => {
          this.$eventBus.$emit('needUpdateStaffList');
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
      this.$refs.position.validate();
      return (this.$refs.fullname.hasError || 
              this.$refs.position.hasError);
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
  }
}
</script>