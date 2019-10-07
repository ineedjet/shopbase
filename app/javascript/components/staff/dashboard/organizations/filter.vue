<template lang="pug">
  q-input(
    label="Поиск"
    v-model.trim="filter"
    debounce="500"
    dark)
</template>

<script>
export default {
	computed: {
		filter: {
			get() {
				return this.$store.state.organizationFilter.filter;
			},
			set(value) {
				this.$store.commit("updateFilter", value);
			}
		}
	}
};
</script>
