<template lang="pug">
	ClientForm(
		title="New Client" 
		action="create"
		)
</template>

<script>
import ClientForm from './form'

export default {
	components: {
		ClientForm,
	},
};
</script>
