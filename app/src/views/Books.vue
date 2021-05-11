<template>
  <section style="height: 100%">
    <add-book-form ref="addBookForm" />
    <delete-book-dialog ref="deleteBookDialog" />
    <!-- Top Navigation -->
    <circular-progress v-if="loading" />
    <v-container class="px-lg-16" v-else>
      <floating-action-button
        :icon="'mdi-plus'"
        :text="'Add new Book'"
        :action="fabAction"
      />

      <title-with-menu />
      <v-divider class="my-4 mb-6"></v-divider>
      <book-list
        :bookInfos="getBookInfos"
        v-on:updateBookDialog="updateBookDialog"
        v-on:deleteBookDialog="deleteBookDialog"
        :updateable="true"
      />
    </v-container>
  </section>
</template>

<script>
import { mapGetters } from "vuex";
import { mapActions } from "vuex";
import FloatingActionButton from "@/components/Core/FloatingActionButton";
import AddBookForm from "../components/Book/AddBookForm.vue";
import BookList from "../components/Book/BookList.vue";
import DeleteBookDialog from "../components/Book/DeleteBookDialog.vue";
import TitleWithMenu from "../components/Book/TitleWithMenu.vue";
import CircularProgress from "../components/Core/CircularProgress";
export default {
  name: "Books",

  components: {
    FloatingActionButton,
    AddBookForm,
    BookList,
    DeleteBookDialog,
    TitleWithMenu,
    CircularProgress,
  },
  data() {
    return {
      loading: false,
    };
  },
  methods: {
    ...mapActions("language", ["bindLanguages"]),
    ...mapActions("author", ["bindAuthors"]),
    ...mapActions("publisher", ["bindPublishers"]),
    ...mapActions("category", ["bindCategories"]),
    ...mapActions("book", ["bindBookInfos"]),
    ...mapActions("state", ["bindStates"]),

    updateBookDialog(e) {
      this.$refs.addBookForm.dialog = true;
      this.$refs.addBookForm.bookInfo = e;
    },

    deleteBookDialog(e) {
      this.$refs.deleteBookDialog.dialog = true;
      this.$refs.deleteBookDialog.name = e.name;
      this.$refs.deleteBookDialog.bookInfoId = e.bookInfoId;
    },
    fabAction() {
      console.log("Action");
      this.$refs.addBookForm.dialog = true;
    },
  },
  computed: {
    ...mapGetters("book", ["getBookInfos"]),
  },

  async created() {
    this.loading = true;
    await this.bindBookInfos({ authorId: null, publisherId: null });
    this.loading = false;
    await this.bindLanguages();
    await this.bindAuthors();
    await this.bindPublishers();
    await this.bindCategories();
    await this.bindStates();
  },
};
</script>

<style scoped>
.v-application ul,
.v-application ol {
  padding: 0;
}
</style>
