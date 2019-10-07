<template lang="pug">
  q-dialog(v-model="isShowDialog" @hide="afterHide()")
    q-card(style="width: 500px; max-width: 80vw;")
      OrganizationForm(:organization="organization")
</template>

<script>
import OrganizationForm from './form'

export default {
  components: {
    OrganizationForm,
	},
  data: function() {
    return {
      isShowDialog: true,
      organization: this.getOrganization(),
    }
  },
  methods: {
    getOrganization() {
      this.$api.organizations
        .show(this.$route.params.id)
        .then(
          response => {
            this.organization = response.data.data.attributes;
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
      this.$router.push("/staffs/dashboard/organizations");
    },
  },
  mounted() {
    this.$eventBus.$on('needCloseDialog', () => {
      this.isShowDialog = false;
    });
  },
}
</script>
