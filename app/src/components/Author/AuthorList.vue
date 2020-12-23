<template>
  <section>
    <v-row justify="center">
      <v-col
        v-for="author in authors"
        :key="author.id"
        cols="12"
        md="4"
        lg="3"
        xl="2"
      >
        <author-card
          :author="author"
          v-on:openDeleteDialog="openDeleteDialog"
        />
      </v-col>
    </v-row>
  </section>
</template>

<script>
import AuthorCard from "./AuthorCard.vue";

export default {
  name: "AuthorList",
  components: { AuthorCard },
  props: {
    authors: {
      type: Array,
      required: true,
    },
  },
  methods: {
    openDeleteDialog(e) {
      this.$emit("openDeleteDialog", e);
    },
  },
};
</script>

<style>
</style>