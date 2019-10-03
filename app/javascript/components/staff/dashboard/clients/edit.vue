<template lang="pug">
  ClientForm(
    title="Edit Client" 
    action="update"
    :client="client"
    )
</template>

<script>
import ClientForm from './form'

export default {
  components: {
    ClientForm,
	},
  props: {
    client: Object,
  },
}
</script>