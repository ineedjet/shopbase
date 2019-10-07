<template lang="pug">
  q-spinner-bars(v-if="isLoading")
  div(v-else)
    q-table.staffs.shadow.bg-gray-100.my-2.rounded(
        title=""
        :data="staffs"
        :columns="columns"
        row-key="id"
        no-data-label="Empty list of staff."
      )
      template(v-slot:body-cell-action="props")
        q-td(:props="props")
          q-btn-group
            q-btn(icon="fas fa-key" @click="resetPassword(props.row)")
            q-btn(icon="fas fa-edit" @click="doEditDialog(props.row)")
            q-btn(icon="fas fa-trash" @click="deleteStaff(props.row)" method="delete")
    router-view(name="editForm")
</template>

<script>
import { required, minLength, email } from '../../../../utils/validations';
import { clone } from '../../../../utils/object';

export default {
  data() {
    return {
      isLoading: true,
      staffs: this.getStaffsList(),
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
          name: 'position',
          align: 'left',
          label: 'Position',
          field: 'position',
          sortable: true,
        },
        { name: 'action', label: 'actions', align: 'left' }
      ],
    };
  },
  methods: {
    getStaffsList() {
      this.$api.staffs
        .index()
        .then(
          (response) => {
            this.staffs = response.data.data.map(i => i.attributes);
          }).finally(() => (this.isLoading = false));
    },
    doEditDialog(row) {
      this.$router.push({ path: `${this.$route.path}/${row.id}/edit` })
    },
    resetPassword(row) {
      this.$api.staffs
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
    deleteStaff(staff) {
      this.$api.staffs
        .destroy(staff.id)
        .then(
          response => {
            this.getStaffsList();
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
    this.$eventBus.$on('needUpdateStaffList', () => {
      this.getStaffsList();
    });
  },
}
</script>
