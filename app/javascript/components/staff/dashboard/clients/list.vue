<template lang="pug">
  q-spinner-bars(v-if="is_loading")
  div(v-else)
    q-table.clients.shadow.my-2.rounded(
        title=""
        :data="clients"
        :columns="columns"
        row-key="id"
        no-data-label="Empty list of client."
        table-class="bg-gray-800 text-gray-400"
        table-header-class="bg-gray-900 text-gray-300"
        card-style="background: #ec0;"
        flat
        bordered
        color="primary"
      )
      template(v-slot:body-cell-action="props")
        q-td(:props="props")
          q-btn-group
            q-btn(icon="fas fa-key" @click="resetPassword(props.row)")
            q-btn(icon="fas fa-edit" @click="doEditDialog(props.row)")
            q-btn(icon="fas fa-trash" @click="deleteClient(props.row)" method="delete")
    router-view(name="editForm")
</template>

<script>
import { required, minLength, email } from '../../../../utils/validations';
import { clone } from '../../../../utils/object';
import ClientEditForm from './edit-dialog'

export default {
  components: {
		ClientEditForm,
	},
  data() {
    return {
      is_loading: true,
      clients: this.getClientsList(),
      columns: [
        {
          name: 'id',
          required: true,
          label: 'ID',
          field: 'id',
          sortable: true,
        },
        {
          name: 'email',
          required: true,
          label: 'Email',
          align: 'left',
          field: 'email',
          sortable: true,
        },
        {
          name: 'fullname',
          required: true,
          label: 'Name',
          align: 'left',
          field: 'fullname',
          sortable: true,
        },
        {
          name: 'phone',
          align: 'left',
          label: 'Phone',
          field: 'phone',
          sortable: true,
        },
        { name: 'action', label: 'actions', align: 'left' }
      ],
      isShowDialog: this.$route.meta.showDialog,
      // editRow: {},
    };
  },
  watch: {
    // "$route.meta"({ showDialog }) {
    //   this.isShowDialog = showDialog;
    // },
    // showDialog: function() {
    //   console.log("this.$route.meta.showDialog = ", this.$route.meta.showDialog);
    //   console.log("this.showDialog = ", this.showDialog);
    // }
  },
  methods: {
    getClientsList() {
      this.$api.clients
        .index()
        .then(
          (response) => {
            this.clients = response.data.data.map(i => i.attributes);
          }).finally(() => (this.is_loading = false));
    },
    doEditDialog(row) {
      this.$router.push({ path: `${this.$route.path}/${row.id}/edit` })
    },
    resetPassword(row) {
      this.$api.clients
        .resetpass(row.id)
        .then(
          response => {
            this.$q.notify({
              icon: 'fas fa-check',
              color: 'positive',
              message: 'Send require for new password'
            })
          },
          errors => {
            this.$q.notify({
              color: 'negative',
              message: errors.response.data
            });
          }
        )
    },
    deleteClient(client) {
      this.$api.clients
        .destroy(client.id)
        .then(
          response => {
            this.getClientsList();
            this.$q.notify({
              icon: 'fas fa-trash',
              color: 'positive',
              message: 'Successfully deleted'
            })
          },
          errors => {
            this.$q.notify({
              color: 'negative',
              message: errors.response.data
            });
          })
    },
    required,
    minLength,
    email,
  },
  mounted() {
    this.$eventBus.$on('needUpdateClientList', () => {
      this.getClientsList();
    });
  },
}
</script>
