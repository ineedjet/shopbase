<template lang="pug">
	q-form.bg-white.m-2.p-4.rounded.shadow-lg(ref='form')
		h5.font-bold.text-2xl
		
		.form-group
			q-input(v-model.trim="staff.email" label="Email" 
				ref="email"
				clearable
				clear-icon="fas fa-window-close"
				:rules="[required, email]"
				)
			span.error(v-for="error in errors.email") {{ error }}
		
		.form-group
			q-input(v-model.trim="staff.fullname" label="Имя" 
				ref="fullname"
				clearable
				clear-icon="fas fa-window-close"
				:rules="[required, val => minLength(val, 5)]"
				)
			span.error(v-for="error in errors.fullname") {{ error }}

		.form-group
			q-input(v-model.trim="staff.position" label="Должность"
				ref="position"
				clearable
				clear-icon="fas fa-window-close"
				:rules="[required]"
				)
			span.error(v-for="error in errors.position") {{ error }}
		
		.submit
			q-btn(type="submit" color="primary" label="Create" @click="SaveNewStaff")
</template>

<script>
import { required, minLength, email } from '../../../../utils/validations';

export default {
	data: function() {
		return {
			staff: {
				email: "",
				fullname: "",
				position: "",
			},
			errors: {
				email: [],
				fullname: [],
				position: [],
			}
		};
	},
	methods: {
		ClearForm() {
			this.organization = {
				email: "",
				fullname: "",
				position: "",
			};
			this.errors = {
				email: [],
				fullname: [],
				position: [],
			};
		},
		SendForm() {
			this.$api.staffs.
					create({
					email: this.staff.email,
					fullname: this.staff.fullname,
					position: this.staff.position,
				}).then(
					response => {
						this.$eventBus.$emit("createStaff");
						this.ClearForm();
						this.$nextTick(() => {
							this.$refs.form.resetValidation();
						});
					},
					errors => {
						this.errors = errors.response.data;
						this.$q.notify({
							color: 'negative',
							message: 'Couldn\'t save this form.'
						});
						this.$nextTick(() => {
							this.$refs.form.resetValidation();
						});
					}
				);
		},
		SaveNewStaff() {
			this.$refs.fullname.validate();
			this.$refs.position.validate();

			if (this.$refs.fullname.hasError || 
					this.$refs.position.hasError) {
        this.$q.notify({
          color: 'negative',
          message: 'Can\'t send it. Some error(s) in form.'
        })
      }else {
				this.SendForm();
        this.$q.notify({
          icon: 'fas fa-check',
          color: 'positive',
          message: 'Submitted'
        })
      }
		},
		required,
		minLength,
		email,
	},
};
</script>

<style scoped>
</style>
