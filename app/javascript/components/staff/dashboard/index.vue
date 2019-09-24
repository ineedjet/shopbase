<template lang="pug">
  .container.mx-auto.flex
    ClientNewForm
    ClientsList(:clients="clients")
</template>

<script>
import ClientNewForm from './client-new';
import ClientsList from './clients-list';

export default {
  components: {
    ClientNewForm,
    ClientsList,
  },
  props: ['clients']
}
</script>

<style scoped>
</style>
