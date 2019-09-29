<template lang="pug">
	q-form.bg-white.m-2.p-4.rounded.shadow-lg(ref='form')
		h5.font-bold.text-2xl
		
		.form-group
			q-input(v-model.trim="organization.name" label="Название" 
				ref="name"
				clearable
				clear-icon="times-circle"
				:rules="[required]"
				)
			span.error(v-for="error in errors.name") {{ error }}

		.form-group
			q-input(v-model.trim="organization.kind" label="Форма организации"
				ref="kind"
				clearable
				clear-icon="times-circle"
				:rules="[required]"
				)
			span.error(v-for="error in errors.kind") {{ error }}
		
		.form-group
			q-input(v-model.number="organization.inn" label="ИНН"
				ref="inn"
				type="number"
				:rules="[required]"
				)
			span.error(v-for="error in errors.inn") {{ error }}
		
		.form-group
			q-input(v-model.number="organization.ogrn" label="ОГРН"
				ref="ogrn"
				type="number"
				:rules="[required]"
				)
			span.error(v-for="error in errors.ogrn") {{ error }}

		.submit
			q-btn(type="submit" color="primary" label="Create" @click="SaveNewOrganization")
</template>

<script>
import { required } from '../../../../utils/validations';

export default {
	data: function() {
		return {
			organization: {
				name: "",
				kind: "",
				inn: "",
				ogrn: ""
			},
			errors: {
				name: [],
				kind: [],
				inn: [],
				ogrn: []
			}
		};
	},
	methods: {
		ClearForm() {
			this.organization = {
				name: "",
				kind: "",
				inn: "",
				ogrn: ""
			};
			this.errors = {
				name: [],
				kind: [],
				inn: [],
				ogrn: []
			};
		},
		SendForm() {
			this.$api.organizations.
					create({
					name: this.organization.name,
					kind: this.organization.kind,
					inn: this.organization.inn,
					ogrn: this.organization.ogrn
				}).then(
					response => {
						this.$eventBus.$emit("createOrganization");
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
		SaveNewOrganization() {
			this.$refs.name.validate();
			this.$refs.kind.validate();
			this.$refs.inn.validate();
			this.$refs.ogrn.validate();

			if (this.$refs.name.hasError || 
					this.$refs.kind.hasError || 
					this.$refs.inn.hasError || 
					this.$refs.ogrn.hasError) {
        this.$q.notify({
          color: 'negative',
          message: 'Can\'t send it. Some error(s) in form.'
        })
      }else {
				this.SendForm();
        this.$q.notify({
          icon: 'done',
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
