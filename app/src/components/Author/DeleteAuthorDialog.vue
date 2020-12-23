<template>
  <v-dialog max-width="400" v-model="dialog">
    <v-card>
      <v-toolbar elevation="1" color="primary" dark>
        <v-toolbar-title class="google-sans-regular"
          >Are you sure to delete that author?</v-toolbar-title
        >
      </v-toolbar>
      <v-card-text class="pt-2 mt-3 text-body-1 secondary--text">
        <span
          >You're about to delete
          <span style="color: #16a085">"{{ fullName }}"</span>. Would you like
          to continue?
        </span>
      </v-card-text>
      <v-card-actions>
        <v-spacer></v-spacer>
        <v-btn :loading="loading" color="primary" @click="_deleteAuthor" text
          >Yes</v-btn
        >
        <v-btn color="secondary" @click="dialog = false" text>No</v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>

<script>
import { mapActions } from "vuex";
export default {
  name: "DeleteAuthorDialog",
  data() {
    return {
      loading: false,
      dialog: false,
      fullName: null,
      authorId: null,
    };
  },
  watch: {
    dialog: function (v) {
      if (!v) {
        this.fullName = null;
        this.authorId = null;
      }
    },
  },
  methods: {
    ...mapActions("author", ["deleteAuthor"]),
    async _deleteAuthor() {
      try {
        this.loading = true;
        const { authorId } = this;
        await this.deleteAuthor({ authorId });
        this.dialog = false;
      } catch (err) {
        console.log(err);
      }
      this.loading = false;
    },
  },
};
</script>

<style>
</style>