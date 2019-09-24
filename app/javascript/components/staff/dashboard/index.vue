<template lang="pug">
  .container.mx-auto.flex
    ClientNewForm(:client="new_client")
    ClientList(:clients="clients")
</template>

<script>
import ClientNewForm from './client-new';
import ClientList from './client-list';

export default {
  components: {
    ClientNewForm,
    ClientList,
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
