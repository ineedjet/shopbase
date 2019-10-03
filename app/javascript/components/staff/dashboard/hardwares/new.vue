<template lang="pug">
	q-form.bg-white.m-2.p-4.rounded.shadow-lg(ref='form')
		h5.font-bold.text-2xl
		
		.form-group
			q-input(v-model.trim="hardware.name" label="Название" 
				ref="name"
				clearable
				clear-icon="fas fa-window-close"
				:rules="[required]"
				)
			span.error(v-for="error in errors.name") {{ error }}

		.form-group
			q-input(v-model.trim="hardware.kind" label="Тип"
				ref="kind"
				clearable
				clear-icon="fas fa-window-close"
				:rules="[required]"
				)
			span.error(v-for="error in errors.kind") {{ error }}

		.form-group
			q-input(v-model.trim="hardware.number" label="Номер"
				ref="number"
				clearable
				clear-icon="fas fa-window-close"
				type="number"
				:rules="[required]"
				)
			span.error(v-for="error in errors.kind") {{ error }}

		.submit
			q-btn(type="submit" color="primary" label="Create" @click="SaveNewHardware")
</template>

<script>
import { required } from '../../../../utils/validations';

export default {
	data: function() {
		return {
			hardware: {
				name: "",
				kind: "",
				number: "",
			},
			errors: {
				name: [],
				kind: [],
				number: [],
			}
		};
	},
	methods: {
		ClearForm() {
			this.hardware = {
				name: "",
				kind: "",
				number: "",
			};
			this.errors = {
				name: [],
				kind: [],
				number: [],
			};
		},
		SendForm() {
			this.$api.hardwares.
					create({
					name: this.hardware.name,
					kind: this.hardware.kind,
					number: this.hardware.number,
				}).then(
					response => {
						this.$eventBus.$emit("createHardware");
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
		SaveNewHardware() {
			this.$refs.name.validate();
			this.$refs.kind.validate();
			this.$refs.number.validate();

			if (this.$refs.name.hasError || 
					this.$refs.kind.hasError ||
					this.$refs.number.hasError) {
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
	},
};
</script>

<style scoped>
</style>
