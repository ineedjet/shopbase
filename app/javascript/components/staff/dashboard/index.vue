<template lang="pug">
  .container.mx-auto.flex
    ClientNewForm(:client="new_client")
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
  props: ['clients'],
  data: function() {
    return {
      new_client: {
        id: 0,
        email: '',
        fullname: '',
        phone: ''
      },
    }
  }
}
</script>

<style scoped>
</style>
