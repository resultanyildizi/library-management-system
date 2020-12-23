<template>
  <ul>
    <v-row jutify="center">
      <v-col
        v-for="bookInfo in getBookInfos"
        :key="bookInfo.bookInfoId"
        md="6"
        xl="4"
        class="pa-0 mb-16"
      >
        <book
          :bookInfo="bookInfo"
          :style="{ 'padding-left': responsivePadding }"
          v-on:updateBookDialog="updateBookDialog"
          v-on:deleteBookDialog="deleteBookDialog"
        />
      </v-col>
    </v-row>
  </ul>
</template>

<script>
import { mapGetters } from "vuex";
import Book from "@/components/Book/Book";
export default {
  name: "BookList",
  components: {
    Book,
  },
  computed: {
    ...mapGetters("book", ["getBookInfos"]),
    responsivePadding() {
      switch (this.$vuetify.breakpoint.name) {
        case "lg":
          return "70px";
        default:
          return "100px";
      }
    },
  },

  methods: {
    updateBookDialog(e) {
      this.$emit("updateBookDialog", e);
    },
    deleteBookDialog(e) {
      this.$emit("deleteBookDialog", e);
    },
  },
};
</script>

<style>
</style>