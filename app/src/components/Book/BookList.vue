<template>
  <ul>
    <v-row jutify="center">
      <v-col
        v-for="bookInfo in bookInfos"
        :key="bookInfo.bookInfoId"
        md="6"
        xl="4"
        class="pa-0 mb-16"
      >
        <book
          :bookInfo="bookInfo"
          :style="{ 'padding-left': responsivePadding }"
          :updateable="updateable"
          v-on:updateBookDialog="updateBookDialog"
          v-on:deleteBookDialog="deleteBookDialog"
        />
      </v-col>
    </v-row>
  </ul>
</template>

<script>
import Book from "@/components/Book/Book";
export default {
  name: "BookList",
  components: {
    Book,
  },
  props: {
    bookInfos: {
      type: Array,
      required: true,
    },
    updateable: {
      type: Boolean,
      required: true,
    },
  },
  computed: {
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