<template lang="pug">
  .container.mx-auto.flex
    ClientNewForm
    ClientList(:clients="clients")
</template>

<script>
import ClientNewForm from './new';
import ClientList from './list';

export default {
  components: {
    ClientNewForm,
    ClientList,
  },
  props: ['clients']
}
</script>

<style scoped>
</style>
