<template>
  <v-dialog max-width="400" v-model="dialog">
    <v-card>
      <v-toolbar elevation="1" color="primary" dark>
        <v-toolbar-title class="google-sans-regular"
          >Are you sure to delete that publisher?</v-toolbar-title
        >
      </v-toolbar>
      <v-card-text class="pt-2 mt-3 text-body-1 secondary--text">
        <span
          >You're about to delete
          <span style="color: #16a085">"{{ name }}"</span>. Would you like to
          continue?
        </span>
      </v-card-text>
      <v-card-actions>
        <v-spacer></v-spacer>
        <v-btn :loading="loading" color="primary" @click="_deletePublisher" text
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
  name: "DeletePublisherDialog",
  data() {
    return {
      loading: false,
      dialog: false,
      name: null,
      publisherId: null,
    };
  },
  watch: {
    dialog: function (v) {
      if (!v) {
        this.name = null;
        this.publisherId = null;
      }
    },
  },
  methods: {
    ...mapActions("publisher", ["deletePublisher"]),
    async _deletePublisher() {
      try {
        this.loading = true;
        const { publisherId } = this;
        await this.deletePublisher({ publisherId });
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