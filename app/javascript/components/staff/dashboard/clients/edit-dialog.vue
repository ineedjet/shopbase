<template lang="pug">
  q-dialog(v-model="isShowDialog" @hide="afterHide()")
    q-card(style="width: 400px; max-width: 80vw;")
      ClientForm(:client="client")
</template>

<script>
import ClientForm from './form'

export default {
  components: {
    ClientForm,
	},
  data: function() {
    return {
      isShowDialog: true,
      client: this.getClient(),
    }
  },
  methods: {
    getClient() {
      this.$api.clients
        .show(this.$route.params.id)
        .then(
          response => {
            this.client = response.data.data.attributes;
          },
          errors => {
            this.$q.notify({
              color: 'negative',
              message: errors.response.data
            });
          }
        )
    },
    afterHide() {
      this.$router.push("/staffs/dashboard/clients");
    },
  },
  mounted() {
    this.$eventBus.$on('needCloseDialog', () => {
      this.isShowDialog = false;
    });
  },
}
</script>