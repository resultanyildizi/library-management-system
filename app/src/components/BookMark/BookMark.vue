<template>
  <v-card color="grey lighten-4" class="my-4">
    <v-card-title class="pb-1">
      <v-icon left color="#16a085">mdi-bookmark</v-icon>
      <span class="google-sans-regular grey--text">
        My note / {{ bookMark.createdAt }}
      </span>
      <v-spacer></v-spacer>
      <v-icon left color="#16a085">mdi-book-open</v-icon>
      <span class="google-sans-regular grey--text"
        >Page / {{ bookMark.page }}</span
      >
      <v-btn icon class="ml-2" @click="_deleteBookMark"
        ><v-icon color="primary">mdi-close</v-icon></v-btn
      >
    </v-card-title>
    <v-card-text class="google-sans-regular text-body-1 black--text px-12">
      {{ bookMark.note }}
    </v-card-text>
  </v-card>
</template>

<script>
import { mapActions } from "vuex";
export default {
  name: "BookMark",
  props: {
    bookMark: {
      type: Object,
      required: true,
    },
  },
  methods: {
    ...mapActions("bookMark", ["deleteBookMark"]),
    async _deleteBookMark() {
      await this.deleteBookMark({
        bookInfoId: this.bookMark.bookInfoId,
        bookMarkId: this.bookMark.bookMarkId,
      });
    },
  },
};
</script>

<style>
.note {
}
</style>