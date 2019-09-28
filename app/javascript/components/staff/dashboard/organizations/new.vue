<template lang="pug">
  .form.bg-white.m-2.p-4.rounded.shadow-lg
    h5.font-bold.text-2xl
    
    .form-group
      label(for="name") Название
      input(
        type="text" id="name" 
        v-model="organization.name"
        )
      span.error(v-for="error in errors.name") {{ error }}

    .form-group
      label(for="kind") Форма организации
      input(
        type="text" id="kind" 
        v-model="organization.kind"
        )
      span.error(v-for="error in errors.kind") {{ error }}
      
    .form-group
      label(for="inn") ИНН
      input(
        type="text" id="inn"
        v-model="organization.inn"
        )
      span.error(v-for="error in errors.inn") {{ error }}

    .form-group
      label(for="ogrn") ОГРН
      input(
        type="text" id="ogrn"
        v-model="organization.ogrn"
        )
      span.error(v-for="error in errors.ogrn") {{ error }}

    .submit
      input(type="submit" value="Create" @click="SaveNewOrganization")
</template>

<script>
export default {
	data: function() {
		return {
			organization: {
				name: "",
				kind: "",
				inn:  "",
				ogrn: ""
			},
			errors: {
				name: [],
				kind: [],
				inn:  [],
				ogrn: []
			}
		};
	},
	methods: {
		ClearForm() {
			this.organization = {
				name: "",
				kind: "",
				inn:  "",
				ogrn: ""
			};
			this.errors = {
				name: [],
				kind: [],
				inn:  [],
				ogrn: []
			};
		},
		SaveNewOrganization() {
			this.$api.organizations
				.create({
					name: this.organization.name,
					kind: this.organization.kind,
					inn:  this.organization.inn,
					ogrn: this.organization.ogrn
				})
				.then(
					response => {
						this.$eventBus.$emit("createOrganization");
						this.ClearForm();
					},
					errors => {
						this.errors = errors.response.data;
					}
				);
		}
	}
};
</script>

<style scoped>
</style>
