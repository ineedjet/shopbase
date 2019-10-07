<template lang="pug">
  q-input(
    label="Поиск"
    v-model.trim="filter"
    dark)
</template>

<script>
export default {
	computed: {
		filter: {
			get() {
				return this.$store.state.filter;
			},
			set(value) {
				this.$store.commit("updateFilter", value);
			}
		}
	}
};
</script>
