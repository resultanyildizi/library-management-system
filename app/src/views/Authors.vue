<template>
  <section style="height: 100%" class="px-8">
    <add-author-form ref="addAuthorForm" />
    <delete-author-dialog ref="deleteAuthorDialog" />
    <circular-progress v-if="!getAuthors" />
    <v-container v-else>
      <floating-action-button
        :icon="'mdi-plus'"
        :text="'Add new Author or Translator'"
        :action="fabAction"
      />
      <title-with-menu />
      <v-divider class="my-4 mb-6"></v-divider>
      <author-list
        :authors="getAuthors"
        v-on:openDeleteDialog="openDeleteDialog"
      />
    </v-container>
  </section>
</template>

<script>
import CircularProgress from "@/components/Core/CircularProgress";
import AuthorList from "../components/Author/AuthorList.vue";
import FloatingActionButton from "../components/Core/FloatingActionButton.vue";
import AddAuthorForm from "../components/Author/AddAuthorForm";
import { mapActions, mapGetters } from "vuex";
import TitleWithMenu from "../components/Author/TitleWithMenu.vue";
import DeleteAuthorDialog from "../components/Author/DeleteAuthorDialog.vue";
export default {
  name: "Authors",
  components: {
    CircularProgress,
    AuthorList,
    FloatingActionButton,
    AddAuthorForm,
    TitleWithMenu,
    DeleteAuthorDialog,
  },
  methods: {
    ...mapActions("author", ["bindAuthors"]),
    ...mapActions("country", ["bindCountries"]),
    fabAction() {
      this.$refs.addAuthorForm.dialog = true;
    },
    openDeleteDialog(e) {
      this.$refs.deleteAuthorDialog.dialog = true;
      this.$refs.deleteAuthorDialog.authorId = e.authorId;
      this.$refs.deleteAuthorDialog.fullName = e.fullName;
    },
  },
  computed: {
    ...mapGetters("author", ["getAuthors"]),
  },
  created() {
    this.bindAuthors();
    this.bindCountries();
  },
};
</script>

<style>
</style>